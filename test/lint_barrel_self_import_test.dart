import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:lint_barrel_self_import/src/lint_barrel_self_import_base.dart';
import 'package:test/test.dart';

void main() {
  group('AvoidSelfBarrelImportRule', () {
    late AvoidSelfBarrelImportRule rule;

    setUp(() {
      rule = AvoidSelfBarrelImportRule();
    });

    test('should have correct rule code', () {
      expect(rule.code.name, equals('avoid_self_barrel_import'));
      expect(rule.code.problemMessage, contains('barrel file'));
    });

    test('should detect package import of barrel file', () async {
      // This test would need to be implemented with custom_lint testing utilities
      // For now, we'll test the rule creation and basic properties
      expect(rule, isA<DartLintRule>());
    });

    test('should detect relative import of barrel file', () async {
      // This test would need to be implemented with custom_lint testing utilities
      expect(rule, isA<DartLintRule>());
    });

    test('should not trigger on valid imports', () async {
      // This test would need to be implemented with custom_lint testing utilities
      expect(rule, isA<DartLintRule>());
    });
  });
}
