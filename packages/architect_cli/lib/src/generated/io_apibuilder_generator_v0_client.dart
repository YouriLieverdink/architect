/// {@template io_apibuilder_generator_v0_client}
/// Documentation for an apibuilder code generator API
/// {@endtemplate}
library io_apibuilder_generator_v0_client;

import 'dart:convert' as _i4;
import 'dart:core' as _i2;

import 'package:http/http.dart' as _i1;

import './io_apibuilder_generator_v0_json.dart' as _i3;

class GeneratorResource {
  const GeneratorResource({
    required this.client,
    required this.baseUrl,
  });

  final _i1.Client client;

  final _i2.String baseUrl;

  /// Get all available generators
  _i2.Future<_i2.List<_i3.Generator>> get({
    _i2.String? key,
    _i2.int limit = 100,
    _i2.int offset = 0,
  }) async {
    final query = {
      'key': key?.toString(),
      'limit': limit.toString(),
      'offset': offset.toString()
    };

    final uri = _i2.Uri.parse(baseUrl)
        .replace(path: '/generators')
        .replace(queryParameters: query);

    final response = await client.get(uri);

    switch (response.statusCode) {
      case 200:
        final json = _i4.jsonDecode(response.body);

        return (json as _i2.List)
            .map((v) => _i3.Generator.fromJson(v))
            .toList();

      default:
        throw _i2.Exception();
    }
  }

  /// Get generator with this key
  _i2.Future<_i3.Generator> getByKey({required _i2.String key}) async {
    final uri = _i2.Uri.parse(baseUrl).replace(path: '/generators/$key');

    final response = await client.get(uri);

    switch (response.statusCode) {
      case 200:
        final json = _i4.jsonDecode(response.body);

        return _i3.Generator.fromJson(json);

      case 404:
        throw _i2.Exception();

      default:
        throw _i2.Exception();
    }
  }
}

class HealthcheckResource {
  const HealthcheckResource({
    required this.client,
    required this.baseUrl,
  });

  final _i1.Client client;

  final _i2.String baseUrl;

  _i2.Future<_i3.Healthcheck> get() async {
    final uri = _i2.Uri.parse(baseUrl).replace(path: '/_internal_/healthcheck');

    final response = await client.get(uri);

    switch (response.statusCode) {
      case 200:
        final json = _i4.jsonDecode(response.body);

        return _i3.Healthcheck.fromJson(json);

      default:
        throw _i2.Exception();
    }
  }
}

class InvocationResource {
  const InvocationResource({
    required this.client,
    required this.baseUrl,
  });

  final _i1.Client client;

  final _i2.String baseUrl;

  /// Invoke a generator
  _i2.Future<_i3.Invocation> postByKey(
    _i3.InvocationForm body, {
    required _i2.String key,
  }) async {
    final uri = _i2.Uri.parse(baseUrl).replace(path: '/invocations/$key');

    final response = await client.post(
      uri,
      body: _i4.jsonEncode(body),
    );

    switch (response.statusCode) {
      case 200:
        final json = _i4.jsonDecode(response.body);

        return _i3.Invocation.fromJson(json);

      case 409:
        final json = _i4.jsonDecode(response.body);

        throw (json as _i2.List).map((v) => _i3.Error.fromJson(v)).toList();

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

  GeneratorResource get generators {
    return GeneratorResource(
      client: client,
      baseUrl: baseUrl,
    );
  }

  HealthcheckResource get healthchecks {
    return HealthcheckResource(
      client: client,
      baseUrl: baseUrl,
    );
  }

  InvocationResource get invocations {
    return InvocationResource(
      client: client,
      baseUrl: baseUrl,
    );
  }
}
