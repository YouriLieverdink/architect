import 'package:shared/shared.dart';

class Definition {
  //
  const Definition(
    this.namespace,
    this.type, {
    this.isLocal = false,
  });

  final String namespace;

  final Type type;

  final bool isLocal;
}
