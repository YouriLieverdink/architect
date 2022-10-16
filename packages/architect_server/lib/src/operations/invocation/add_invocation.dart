import 'package:architect/architect.dart';

import '../../generated/io_apibuilder_generator_v0_json.dart' as i1;
import '../../generated/nl_pipbo_slack_v0_json.dart' as i2;

class CreateAddInvocation {
  //
  const CreateAddInvocation(
    this.showGenerator,
    this.addMessage,
  );

  final Future<Generator> Function(
    String key,
  ) showGenerator;

  final Future<void> Function(
    i2.Message message,
  ) addMessage;

  Future<i1.Invocation> call(
    String key,
    i1.InvocationForm form,
  ) async {
    final generator = await showGenerator(key);

    try {
      final output = generator(form.toJson());

      return i1.Invocation.fromJson(output);
    } //
    catch (e) {
      final message = i2.Message(
        text: e.toString(),
        username: 'architect',
      );

      await addMessage(message);

      throw i1.Error(
        code: 'invocation-error',
        message: e.toString(),
      );
    }
  }
}
