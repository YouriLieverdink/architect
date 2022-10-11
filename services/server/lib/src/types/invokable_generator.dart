import 'package:server/server.dart';

class InvokableGenerator extends Generator {
  //
  const InvokableGenerator({
    required super.key,
    required super.name,
    super.language,
    super.description,
    required super.attributes,
    required this.build,
  });

  final Invocation Function(InvocationForm form) build;
}
