import 'package:architect/architect.dart';

import '../generated/io_apibuilder_generator_v0_json.dart' as i1;

class DartClient extends Generator {
  //
  const DartClient({
    required super.key,
    required super.name,
    required super.version,
  }) : super(
          language: 'dart',
          description: 'Complete Http client using the Dart http package.',
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
