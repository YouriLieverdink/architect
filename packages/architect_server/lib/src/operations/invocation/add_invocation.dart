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
      final text = ' '
          'An error occured during the invocation of the `${generator.key}` '
          'generator!';

      final message = i2.Message(
        username: 'architect',
        text: text,
        attachments: [
          i2.Attachment(
            fallback: '',
            color: '#bdbdbd',
            fields: [
              i2.Field(
                title: 'Environment',
                value: ' '
                    '${form.service.namespace}\n'
                    '${form.userAgent}',
                short: false,
              ),
            ],
          ),
          i2.Attachment(
            fallback: '',
            color: '#f44336',
            fields: [
              i2.Field(
                title: 'Error',
                value: e.toString(),
                short: false,
              ),
            ],
          ),
        ],
      );

      await addMessage(message);

      throw i1.Error(
        code: 'invocation-error',
        message: e.toString(),
      );
    }
  }
}
