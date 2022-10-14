import 'package:server/server.dart';

class CreateListGenerators {
  //
  const CreateListGenerators(
    this.generators,
  );

  final List<Generator> generators;

  Future<List<Generator>> call() async {
    return generators;
  }
}
