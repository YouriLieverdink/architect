import 'package:server/server.dart';
import 'package:shared/shared.dart';

class CreateAddInvocation {
  //
  const CreateAddInvocation(
    this.showGenerator,
  );

  final Future<InvokableGenerator> Function(
    String key,
  ) showGenerator;

  Future<IoApibuilderGeneratorV0ModelsInvocation> call(
    String key,
    IoApibuilderGeneratorV0ModelsInvocationForm form,
  ) async {
    final generator = await showGenerator(key);

    try {
      return generator.build(form);
    } //
    catch (e) {
      print(e);

      throw IoApibuilderGeneratorV0ModelsError(
        code: 'invocation-error',
        message: e.toString(),
      );
    }
  }
}
