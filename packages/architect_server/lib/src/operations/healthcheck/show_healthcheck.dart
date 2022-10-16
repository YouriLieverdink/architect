import 'package:architect_server/architect_server.dart';

import '../../generated/io_apibuilder_generator_v0_json.dart' as i1;

class CreateShowHealthcheck {
  //
  const CreateShowHealthcheck();

  Future<i1.Healthcheck> call() async {
    // Ensure all environment variables are available.
    if (slackWebhookUrl.isEmpty) {
      throw const i1.Error(
        code: 'environment-error',
        message: 'The variable with key `SLACK_WEBHOOK_URL` is unavailable.',
      );
    }

    return const i1.Healthcheck(
      status: 'healthy',
    );
  }
}
