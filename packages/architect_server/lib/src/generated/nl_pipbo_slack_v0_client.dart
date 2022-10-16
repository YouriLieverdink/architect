library nl_pipbo_slack_v0_client;

import 'dart:convert' as _i4;
import 'dart:core' as _i2;

import 'package:http/http.dart' as _i1;

import './nl_pipbo_slack_v0_json.dart' as _i3;

class MessageResource {
  const MessageResource({
    required this.client,
    required this.baseUrl,
  });

  final _i1.Client client;

  final _i2.String baseUrl;

  _i2.Future<void> post(_i3.Message body) async {
    final uri = _i2.Uri.parse(baseUrl);

    final response = await client.post(
      uri,
      body: _i4.jsonEncode(body),
    );

    switch (response.statusCode) {
      case 200:
        break;

      default:
        throw _i2.Exception();
    }
  }
}

class Client {
  const Client({
    required this.client,
    required this.baseUrl,
  });

  final _i1.Client client;

  final _i2.String baseUrl;

  MessageResource get messages {
    return MessageResource(
      client: client,
      baseUrl: baseUrl,
    );
  }
}
