import 'dart:convert';

import 'package:server/server.dart';
import 'package:shelf_plus/shelf_plus.dart';

import '../generated/io_apibuilder_generator_v0_json.dart' as i1;

class InvocationController {
  //
  static Future<Response> postByKey(
    Request request,
    String key,
  ) async {
    final json = await request.body.asJson;
    final form = i1.InvocationForm.fromJson(json);

    try {
      final data = await addInvocation(key, form);

      return Response(200, body: jsonEncode(data));
    } //
    on i1.Error catch (e) {
      return Response(409, body: jsonEncode([e]));
    }
  }
}
