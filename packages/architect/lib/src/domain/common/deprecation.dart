import 'package:orchestrator/orchestrator.dart';

import '../../generated/io_apibuilder_spec_v0_json.dart' as i1;

Annotation buildDeprecation(
  i1.Deprecation deprecation,
) {
  return Annotation(
    type: const TypeReference(
      'Deprecated',
      url: 'dart:core',
    ),
    arguments: () sync* {
      //
      final description = deprecation.description ?? '';

      yield Literal.of(description);
    }(),
  );
}
