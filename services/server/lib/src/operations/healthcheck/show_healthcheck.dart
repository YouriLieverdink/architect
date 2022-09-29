import 'package:shared/shared.dart';

class CreateShowHealthcheck {
  //
  const CreateShowHealthcheck();

  Future<IoApibuilderGeneratorV0ModelsHealthcheck> call() async {
    return const IoApibuilderGeneratorV0ModelsHealthcheck(
      status: 'healthy',
    );
  }
}
