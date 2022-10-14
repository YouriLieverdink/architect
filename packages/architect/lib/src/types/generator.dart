import '../generated/io_apibuilder_generator_v0_json.dart' as i1;

/// {@template dart_version}
///
/// {@endtemplate}
enum DartVersion { twoFifteen, twoSeventeen }

/// {@template generator}
///
/// {@endtemplate}
abstract class Generator extends i1.Generator {
  /// {@macro generator}
  const Generator({
    required super.key,
    required super.name,
    super.language,
    super.description,
    required super.attributes,
    this.version = DartVersion.twoFifteen,
  });

  final DartVersion version;

  i1.Invocation call(
    i1.InvocationForm form,
  );
}
