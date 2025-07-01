// This should trigger a warning (when used with the actual lint)
// import 'package:test_package/test_package.dart'; // expect_lint: avoid_self_barrel_import

import '../test_package.dart';

void useBadImport() {
  // Using imported classes
  final some = SomeClass();
  some.doSomething();
} 