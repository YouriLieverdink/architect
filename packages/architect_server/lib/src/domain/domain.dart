import 'package:architect_server/architect_server.dart';
import 'package:http/http.dart';

import '../generated/nl_pipbo_slack_v0_client.dart' as i1;

final client = i1.Client(
  client: Client(),
  baseUrl: slackWebhookUrl,
);
