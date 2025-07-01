// These should NOT trigger warnings
import 'package:test_package/src/another_class.dart';
import 'package:test_package/src/some_class.dart';

/// Demonstrates usage of good imports.
void useGoodImports() {
  final some = SomeClass();
  final another = AnotherClass();
  some.doSomething();
  another.doAnotherThing();
} 
