// These should NOT trigger warnings
import 'some_class.dart';
import 'another_class.dart';

void useGoodImports() {
  final some = SomeClass();
  final another = AnotherClass();
  some.doSomething();
  another.doAnotherThing();
} 