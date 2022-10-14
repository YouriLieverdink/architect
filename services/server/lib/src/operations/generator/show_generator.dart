import 'package:server/server.dart';

import '../../generated/io_apibuilder_generator_v0_json.dart' as i1;

class CreateShowGenerator {
  //
  const CreateShowGenerator(
    this.generators,
  );

  final List<Generator> generators;

  Future<Generator> call(
    String key,
  ) async {
    try {
      return generators //
          .where((v) => v.key == key)
          .first;
    } //
    catch (_) {
      throw i1.Error(
        code: 'not-found',
        message: 'The generator with key $key was not found.',
      );
    }
  }
}
