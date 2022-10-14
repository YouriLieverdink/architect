import 'package:server/server.dart';

import '../../generated/io_apibuilder_generator_v0_json.dart' as i1;

class CreateAddInvocation {
  //
  const CreateAddInvocation(
    this.showGenerator,
  );

  final Future<Generator> Function(
    String key,
  ) showGenerator;

  Future<i1.Invocation> call(
    String key,
    i1.InvocationForm form,
  ) async {
    final generator = await showGenerator(key);

    try {
      return generator.build(form);
    } //
    catch (e) {
      throw i1.Error(
        code: 'invocation-error',
        message: e.toString(),
      );
    }
  }
}
