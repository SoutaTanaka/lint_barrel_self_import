# Example Usage of lint_barrel_self_import

This example demonstrates how the `lint_barrel_self_import` custom lint rule works.

## Setup

1. Install dependencies:

```bash
dart pub get
```

2. Run analysis to see the lint warnings:

```bash
dart analyze
```

## Files

- `lib/src/bad_example.dart` - Contains imports that will trigger warnings
- `lib/src/good_example.dart` - Contains correct imports that won't trigger warnings
- `lib/example.dart` - The barrel file for this example package

## Expected Output

When you run `dart analyze`, you should see warnings for the imports in `bad_example.dart` but no warnings for `good_example.dart`.
