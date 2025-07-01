import 'dart:io';
import 'package:analyzer/error/error.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:lint_barrel_self_import/src/lint_barrel_self_import_base.dart';
import 'package:test/test.dart';

void main() {
  group('AvoidSelfBarrelImportRule', () {
    late AvoidSelfBarrelImportRule rule;

    setUp(() {
      rule = const AvoidSelfBarrelImportRule();
    });

    test('should have correct rule code', () {
      expect(rule.code.name, equals('avoid_self_barrel_import'));
      expect(rule.code.problemMessage, contains('barrel file'));
      expect(
        rule.code.correctionMessage,
        contains('Import specific files directly'),
      );
      expect(rule.code.errorSeverity, equals(ErrorSeverity.WARNING));
    });

    group('rule implementation tests', () {
      test('should be a DartLintRule', () {
        expect(rule, isA<DartLintRule>());
      });

      test('should have non-empty rule name', () {
        expect(rule.code.name, isNotEmpty);
      });

      test('should have meaningful problem message', () {
        expect(rule.code.problemMessage, contains('barrel file'));
        expect(rule.code.problemMessage, contains('package'));
      });

      test('should provide helpful correction message', () {
        expect(rule.code.correctionMessage, isNotNull);
        expect(rule.code.correctionMessage, isNotEmpty);
      });
    });

    group('integration tests with expect_lint comments', () {
      test(
        'fixture files should exist and have proper expect_lint comments',
        () {
        final badImportPackageFile = File(
          'test/fixtures/test_package/lib/src/bad_import_package.dart',
        );
        final badImportRelativeFile = File(
          'test/fixtures/test_package/lib/src/bad_import_relative.dart',
        );
        final goodImportFile = File(
          'test/fixtures/test_package/lib/src/good_import.dart',
        );

        expect(
          badImportPackageFile.existsSync(),
          isTrue,
          reason: 'bad_import_package.dart should exist',
        );
        expect(
          badImportRelativeFile.existsSync(),
          isTrue,
          reason: 'bad_import_relative.dart should exist',
        );
        expect(
          goodImportFile.existsSync(),
          isTrue,
          reason: 'good_import.dart should exist',
        );

        // Check that expect_lint comments are properly placed
        final badPackageContent = badImportPackageFile.readAsStringSync();
        final badRelativeContent = badImportRelativeFile.readAsStringSync();
        final goodContent = goodImportFile.readAsStringSync();

        expect(
          badPackageContent,
          contains('expect_lint: avoid_self_barrel_import'),
        );
        expect(
          badRelativeContent,
          contains('expect_lint: avoid_self_barrel_import'),
        );
        expect(
          goodContent,
          isNot(contains('expect_lint')),
          reason: 'Good import file should not have expect_lint comments',
        );

        // Verify the imports are as expected
        expect(
          badPackageContent,
          contains('package:test_package/test_package.dart'),
        );
        expect(
          badRelativeContent,
          contains('package:test_package/test_package.dart'),
        );
        expect(goodContent, contains('package:test_package/src/'));
      });

      test('barrel file should exist', () {
        final barrelFile = File(
          'test/fixtures/test_package/lib/test_package.dart',
        );
        expect(
          barrelFile.existsSync(),
          isTrue,
          reason: 'Barrel file should exist',
        );

        final content = barrelFile.readAsStringSync();
        expect(
          content,
          contains('export'),
          reason: 'Barrel file should contain export statements',
        );
      });
    });

    group('test fixture validation', () {
      test('test_package should have correct structure', () {
        final testPackageDir = Directory('test/fixtures/test_package');
        final pubspecFile = File('test/fixtures/test_package/pubspec.yaml');
        final libDir = Directory('test/fixtures/test_package/lib');
        final srcDir = Directory('test/fixtures/test_package/lib/src');

        expect(testPackageDir.existsSync(), isTrue);
        expect(pubspecFile.existsSync(), isTrue);
        expect(libDir.existsSync(), isTrue);
        expect(srcDir.existsSync(), isTrue);

        // Verify pubspec.yaml has correct package name
        final pubspecContent = pubspecFile.readAsStringSync();
        expect(pubspecContent, contains('name: test_package'));
      });

      test('source files should have expected classes', () {
        final someClassFile = File(
          'test/fixtures/test_package/lib/src/some_class.dart',
        );
        final anotherClassFile = File(
          'test/fixtures/test_package/lib/src/another_class.dart',
        );

        expect(someClassFile.existsSync(), isTrue);
        expect(anotherClassFile.existsSync(), isTrue);

        final someClassContent = someClassFile.readAsStringSync();
        final anotherClassContent = anotherClassFile.readAsStringSync();

        expect(someClassContent, contains('class SomeClass'));
        expect(anotherClassContent, contains('class AnotherClass'));
      });
    });
  });
}
