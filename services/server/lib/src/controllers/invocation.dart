import 'dart:convert';

import 'package:server/server.dart';
import 'package:shared/shared.dart';
import 'package:shelf_plus/shelf_plus.dart';

class InvocationController {
  //
  static Future<Response> postByKey(
    Request request,
    String key,
  ) async {
    final json = await request.body.asJson;
    final form = IoApibuilderGeneratorV0ModelsInvocationForm.fromJson(json);

    try {
      final data = await addInvocation(key, form);

      return Response(200, body: jsonEncode(data));
    } //
    on IoApibuilderGeneratorV0ModelsError catch (e) {
      return Response(409, body: jsonEncode([e]));
    }
  }
}
