import 'dart:convert';

import 'package:server/server.dart';
import 'package:shelf_plus/shelf_plus.dart';

class GeneratorController {
  //
  static Future<Response> get(
    Request request,
  ) async {
    final data = await listGenerators();

    return Response(200, body: jsonEncode(data));
  }

  static Future<Response> getByKey(
    Request request,
    String key,
  ) async {
    try {
      final data = await showGenerator(key);

      return Response(200, body: jsonEncode(data));
    } //
    catch (_) {
      return Response(404);
    }
  }
}
