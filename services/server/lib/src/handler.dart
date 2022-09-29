import 'package:server/server.dart';
import 'package:shelf_plus/shelf_plus.dart';

Handler handler() {
  //
  final handler = RouterPlus();

  handler.use(setContentType('application/json'));

  return handler //
    ..get('/_internal_/healthcheck', HealthcheckController.get)
    ..post('/invocations/<key>', InvocationController.postByKey)
    ..get('/generators', GeneratorController.get)
    ..get('/generators/<key>', GeneratorController.getByKey);
}
