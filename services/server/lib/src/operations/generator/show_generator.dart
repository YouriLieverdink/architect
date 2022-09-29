import 'package:server/server.dart';
import 'package:shared/shared.dart';

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
      throw IoApibuilderGeneratorV0ModelsError(
        code: 'not-found',
        message: 'The generator with key $key was not found.',
      );
    }
  }
}
