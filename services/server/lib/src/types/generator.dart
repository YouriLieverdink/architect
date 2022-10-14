// ignore: always_use_package_imports
import '../generated/io_apibuilder_generator_v0_json.dart' as i1;

enum GeneratorVersion { v215, v217 }

abstract class Generator extends i1.Generator {
  //
  const Generator({
    required super.key,
    required super.name,
    super.language,
    super.description,
    required super.attributes,
    required this.version,
  });

  final GeneratorVersion version;

  i1.Invocation build(
    i1.InvocationForm form,
  );
}
