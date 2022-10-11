import 'package:server/server.dart';

class CreateShowGenerator {
  //
  const CreateShowGenerator(
    this.generators,
  );

  final List<InvokableGenerator> generators;

  Future<InvokableGenerator> call(
    String key,
  ) async {
    try {
      return generators //
          .where((v) => v.key == key)
          .first;
    } //
    catch (_) {
      throw Error(
        code: 'not-found',
        message: 'The generator with key $key was not found.',
      );
    }
  }
}
