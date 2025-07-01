/// A custom lint rule to avoid importing a package's own barrel file
/// from within that package.
library;

import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:lint_barrel_self_import/src/lint_barrel_self_import_base.dart';

export 'src/lint_barrel_self_import_base.dart';

/// Creates the plugin for the lint_barrel_self_import package.
PluginBase createPlugin() => _BarrelSelfImportLinter();

class _BarrelSelfImportLinter extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) => [
        const AvoidSelfBarrelImportRule(),
      ];
}
