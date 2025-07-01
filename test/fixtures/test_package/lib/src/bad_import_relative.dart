// This should trigger a warning
// expect_lint: avoid_self_barrel_import
import 'package:test_package/test_package.dart';

/// Demonstrates usage of bad relative import.
void useBadRelativeImport() {
  // Using imported classes
  AnotherClass().doAnotherThing();
} 
