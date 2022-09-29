import 'package:dart_style/dart_style.dart';
import 'package:orchestrator/orchestrator.dart';

String emit(
  Element element,
) {
  final importer = PrefixImporter(exclude: const []);
  final context = Context(importer: importer, useTraillingCommas: true);
  final emitter = ElementEmitter(context);

  final formatter = DartFormatter();

  return formatter.format('${emitter.emit(element)}');
}
