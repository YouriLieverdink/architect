import 'package:dotenv/dotenv.dart';

final _env = DotEnv(includePlatformEnvironment: true) //
  ..load([]);

String get slackWebhookUrl => _env['SLACK_WEBHOOK_URL'] ?? '';
