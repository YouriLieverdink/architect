import 'package:server/server.dart';

class CreateShowHealthcheck {
  //
  const CreateShowHealthcheck();

  Future<Healthcheck> call() async {
    return const Healthcheck(
      status: 'healthy',
    );
  }
}
