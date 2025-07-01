// Example usage of lint_barrel_self_import
// 
// This file demonstrates how the lint rule works.
// Run `dart analyze` to see the warnings in action.

import 'lib/src/good_example.dart';

void main() {
  print('Running lint_barrel_self_import example...');
  print('Check lib/src/bad_example.dart to see lint warnings');
  print('Check lib/src/good_example.dart to see correct usage');
  
  demonstrateGoodImports();
}
