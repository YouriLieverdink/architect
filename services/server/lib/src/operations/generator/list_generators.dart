import 'package:server/server.dart';

class CreateListGenerators {
  //
  const CreateListGenerators(
    this.generators,
  );

  final List<InvokableGenerator> generators;

  Future<List<InvokableGenerator>> call() async {
    return generators;
  }
}
