// This file demonstrates the lint rule in action
// The following import should trigger a warning:

import 'package:example/example.dart'; // This should trigger a warning

void demonstrateBadImports() {
  // This code would work, but violates the lint rule
  final example = ExampleClass();
  example.doSomething();
} 