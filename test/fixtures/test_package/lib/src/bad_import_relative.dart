// This should trigger a warning
import 'package:test_package/test_package.dart'; // expect_lint: avoid_self_barrel_import

/// Demonstrates usage of bad relative import.
void useBadRelativeImport() {
  // Using imported classes
  AnotherClass().doAnotherThing();
} 
