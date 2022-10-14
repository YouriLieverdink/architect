import '../../generated/io_apibuilder_generator_v0_json.dart' as i1;

class CreateShowHealthcheck {
  //
  const CreateShowHealthcheck();

  Future<i1.Healthcheck> call() async {
    return const i1.Healthcheck(
      status: 'healthy',
    );
  }
}
