import 'dart:convert';

import 'package:cli/cli.dart';
import 'package:http/http.dart';

class IoApibuilderGeneratorV0ModelsGeneratorResource {
  const IoApibuilderGeneratorV0ModelsGeneratorResource({
    required this.client,
    required this.baseUrl,
  });

  final Client client;

  final String baseUrl;

  Future<List<IoApibuilderGeneratorV0ModelsGenerator>> get({
    String? key,
    int limit = 100,
    int offset = 0,
  }) async {
    final r = await client.get(
      Uri.parse('$baseUrl/generators').replace(
        queryParameters: {
          if (key != null) ...{
            'key': jsonEncode(key),
          },
          'limit': jsonEncode(limit),
          'offset': jsonEncode(offset)
        },
      ),
    );

    final json = jsonDecode(r.body);

    switch (r.statusCode) {
      case 200:
        return (json as List)
            .map((v) => IoApibuilderGeneratorV0ModelsGenerator.fromJson(v))
            .toList();

      default:
        throw Exception([
          r.statusCode,
          'Unsupported status code: ${r.statusCode}, expected 200.'
        ]);
    }
  }

  Future<IoApibuilderGeneratorV0ModelsGenerator> getByKey({
    required String key,
  }) async {
    final r = await client.get(
      Uri.parse('$baseUrl/generators/$key'),
    );

    final json = jsonDecode(r.body);

    switch (r.statusCode) {
      case 200:
        return IoApibuilderGeneratorV0ModelsGenerator.fromJson(json);

      case 404:
        throw Exception([
          r.statusCode,
          null,
        ]);

      default:
        throw Exception([
          r.statusCode,
          'Unsupported status code: ${r.statusCode}, expected 200, 404.',
        ]);
    }
  }
}

class IoApibuilderGeneratorV0ModelsHealthcheckResource {
  const IoApibuilderGeneratorV0ModelsHealthcheckResource({
    required this.client,
    required this.baseUrl,
  });

  final Client client;

  final String baseUrl;

  Future<IoApibuilderGeneratorV0ModelsHealthcheck> get() async {
    final r = await client.get(
      Uri.parse('$baseUrl/_internal_/healthcheck'),
    );

    final json = jsonDecode(r.body);

    switch (r.statusCode) {
      case 200:
        return IoApibuilderGeneratorV0ModelsHealthcheck.fromJson(json);

      default:
        throw Exception([
          r.statusCode,
          'Unsupported status code: ${r.statusCode}, expected 200.',
        ]);
    }
  }
}

class IoApibuilderGeneratorV0ModelsInvocationResource {
  const IoApibuilderGeneratorV0ModelsInvocationResource({
    required this.client,
    required this.baseUrl,
  });

  final Client client;

  final String baseUrl;

  Future<IoApibuilderGeneratorV0ModelsInvocation> postByKey(
    IoApibuilderGeneratorV0ModelsInvocationForm invocationForm, {
    required String key,
  }) async {
    final r = await client.post(
      Uri.parse('$baseUrl/invocations/$key'),
      body: jsonEncode(invocationForm),
    );

    final json = jsonDecode(r.body);

    switch (r.statusCode) {
      case 200:
        return IoApibuilderGeneratorV0ModelsInvocation.fromJson(json);

      case 409:
        throw Exception([
          r.statusCode,
          null,
        ]);

      default:
        throw Exception([
          r.statusCode,
          'Unsupported status code: ${r.statusCode}, expected 200, 409.'
        ]);
    }
  }
}

class IoApibuilderGeneratorV0Client {
  const IoApibuilderGeneratorV0Client({
    required this.client,
    required this.baseUrl,
  });

  final Client client;

  final String baseUrl;

  IoApibuilderGeneratorV0ModelsGeneratorResource get generators {
    return IoApibuilderGeneratorV0ModelsGeneratorResource(
      baseUrl: baseUrl,
      client: client,
    );
  }

  IoApibuilderGeneratorV0ModelsHealthcheckResource get healthchecks {
    return IoApibuilderGeneratorV0ModelsHealthcheckResource(
      baseUrl: baseUrl,
      client: client,
    );
  }

  IoApibuilderGeneratorV0ModelsInvocationResource get invocations {
    return IoApibuilderGeneratorV0ModelsInvocationResource(
      baseUrl: baseUrl,
      client: client,
    );
  }
}
