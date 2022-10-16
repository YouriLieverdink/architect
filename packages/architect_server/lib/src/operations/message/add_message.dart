import '../../generated/nl_pipbo_slack_v0_client.dart' as i1;
import '../../generated/nl_pipbo_slack_v0_json.dart' as i2;

class CreateAddMessage {
  //
  const CreateAddMessage(
    this.client,
  );

  final i1.Client client;

  Future<void> call(
    i2.Message message,
  ) async {
    try {
      await client.messages.post(message);
    } //
    catch (_) {}
  }
}
