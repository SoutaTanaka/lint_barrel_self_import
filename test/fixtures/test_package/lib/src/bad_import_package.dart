// This should trigger a warning (when used with the actual lint)
// expect_lint: avoid_self_barrel_import
import 'package:test_package/test_package.dart';

/// Demonstrates usage of bad package import.
void useBadImport() {
  // Using imported classes
  SomeClass().doSomething();
} 
