import 'package:analyzer/error/error.dart' hide LintCode;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:path/path.dart' as path;

/// A lint rule that detects imports of a package's own barrel file.
class AvoidSelfBarrelImportRule extends DartLintRule {
  const AvoidSelfBarrelImportRule() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_self_barrel_import',
    problemMessage: 'Avoid importing the package\'s own barrel file from within the package.',
    correctionMessage: 'Import specific files directly instead of using the barrel file.',
    errorSeverity: ErrorSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    // Get the package name from the context
    final packageName = context.pubspec.name;
    if (packageName.isEmpty) return;

    // Define the barrel file name
    final barrelFileName = '$packageName.dart';

    context.registry.addImportDirective((node) {
      final importUri = node.uri.stringValue;
      if (importUri == null) return;

      // Check for package: URI imports
      if (importUri.startsWith('package:$packageName/$barrelFileName')) {
        reporter.atNode(node, _code);
        return;
      }

      // Check for relative path imports
      if (importUri.startsWith('./') || importUri.startsWith('../')) {
        try {
          // Get the current file path
          final currentFilePath = resolver.source.fullName;
          final currentDir = path.dirname(currentFilePath);
          
          // Resolve the relative import to an absolute path
          final resolvedPath = path.normalize(path.join(currentDir, importUri));
          
          // Get the package root directory (assuming lib directory structure)
          final packageRoot = _findPackageRoot(currentFilePath);
          if (packageRoot == null) return;
          
          // Check if the resolved path points to the barrel file
          final expectedBarrelPath = path.join(packageRoot, 'lib', barrelFileName);
          
          if (path.equals(resolvedPath, expectedBarrelPath)) {
            reporter.atNode(node, _code);
          }
        } catch (e) {
          // If path resolution fails, skip this check
          return;
        }
      }
    });
  }

  /// Finds the package root directory by looking for pubspec.yaml
  String? _findPackageRoot(String filePath) {
    var current = path.dirname(filePath);
    
    while (current != path.dirname(current)) {
      final pubspecPath = path.join(current, 'pubspec.yaml');
      if (path.isAbsolute(pubspecPath)) {
        // In a real implementation, we would check if the file exists
        // For now, we assume the package root is the parent of 'lib'
        if (current.endsWith('lib')) {
          return path.dirname(current);
        }
        if (path.basename(current) == 'lib') {
          return path.dirname(current);
        }
        // Check if this directory contains a lib subdirectory
        final libPath = path.join(current, 'lib');
        if (filePath.startsWith(libPath)) {
          return current;
        }
      }
      current = path.dirname(current);
    }
    
    return null;
  }
} 