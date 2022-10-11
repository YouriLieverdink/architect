import 'package:server/server.dart';

class CreateAddInvocation {
  //
  const CreateAddInvocation(
    this.showGenerator,
  );

  final Future<InvokableGenerator> Function(
    String key,
  ) showGenerator;

  Future<Invocation> call(
    String key,
    InvocationForm form,
  ) async {
    final generator = await showGenerator(key);

    try {
      return generator.build(form);
    } //
    catch (e) {
      throw Error(
        code: 'invocation-error',
        message: e.toString(),
      );
    }
  }
}
