// This should trigger a warning
import '../test_package.dart'; // expect_lint: avoid_self_barrel_import

void useBadRelativeImport() {
  // Using imported classes
  final another = AnotherClass();
  another.doAnotherThing();
} 