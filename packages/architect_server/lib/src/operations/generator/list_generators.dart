import 'package:architect/architect.dart';

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
