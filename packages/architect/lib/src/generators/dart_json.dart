import 'package:architect/architect.dart';

import '../generated/io_apibuilder_generator_v0_json.dart' as i1;

class DartJson extends Generator {
  //
  const DartJson({
    required super.key,
    required super.name,
    required super.version,
  }) : super(
          language: 'dart',
          description: 'Classes with toJson, fromJson, and copyWith methods',
          attributes: const [],
        );

  @override
  i1.Invocation build(
    i1.InvocationForm form,
  ) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
