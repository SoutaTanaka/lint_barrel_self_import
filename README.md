<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages). 
-->

# lint_barrel_self_import

A custom lint rule to avoid importing a package's own barrel file from within that package.

## Problem

When developing Dart packages, it's common to create a "barrel file" (e.g., `package_name.dart`) that re-exports all public APIs. However, importing this barrel file from within the same package can lead to:

- Circular dependency issues
- Unnecessary indirection
- Performance overhead
- Maintenance complexity

## Solution

This lint rule detects and warns against importing a package's own barrel file from within that package, whether through:

- `package:` URI imports (e.g., `import 'package:my_package/my_package.dart';`)
- Relative path imports (e.g., `import './my_package.dart';` or `import '../lib/my_package.dart';`)

## Installation

Add the following to your `pubspec.yaml`:

```yaml
dev_dependencies:
  custom_lint: ^0.6.4
  lint_barrel_self_import: ^0.1.0
```

Then run:

```bash
dart pub get
```

## Usage

Add the following to your `analysis_options.yaml`:

```yaml
analyzer:
  plugins:
    - custom_lint
```

## Examples

### ❌ Bad (will trigger warnings)

```dart
// In lib/src/some_file.dart
import 'package:my_package/my_package.dart'; // Warning: avoid importing barrel file

// In lib/src/another_file.dart  
import '../my_package.dart'; // Warning: avoid importing barrel file

// In lib/nested/deep_file.dart
import '../../lib/my_package.dart'; // Warning: avoid importing barrel file
```

### ✅ Good (no warnings)

```dart
// In lib/src/some_file.dart
import 'another_file.dart'; // OK: importing other files within package
import 'package:other_package/other_package.dart'; // OK: importing other packages

// In lib/src/another_file.dart
import '../utils/helper.dart'; // OK: importing specific files
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
