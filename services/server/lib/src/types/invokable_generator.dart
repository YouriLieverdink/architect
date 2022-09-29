import 'package:shared/shared.dart';

class InvokableGenerator extends IoApibuilderGeneratorV0ModelsGenerator {
  //
  const InvokableGenerator({
    required super.key,
    required super.name,
    super.language,
    super.description,
    required super.attributes,
    required this.invoke,
  });

  final IoApibuilderGeneratorV0ModelsInvocation Function(
    IoApibuilderGeneratorV0ModelsInvocationForm form,
  ) invoke;
}
