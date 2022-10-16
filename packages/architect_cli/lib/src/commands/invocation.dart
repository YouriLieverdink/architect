import 'dart:io';

import 'package:architect_cli/architect_cli.dart';
import 'package:args/command_runner.dart';
import 'package:collection/collection.dart';

import '../generated/io_apibuilder_generator_v0_json.dart' as i1;

class InvocationCommand extends Command {
  //
  InvocationCommand();

  @override
  String get name => 'invoke';

  @override
  String get description => 'Invokes a code generator.';

  @override
  Future<void> run() async {
    final key = argResults?.rest.firstOrNull;

    if (key == null) {
      throw UsageException('Missing key for "dev invoke <key>"', usage);
    }

    try {
      final json = await File('../../assets/service.json').readAsJson();
      final form = i1.InvocationForm.fromJson(json);

      final data = await client.invocations.postByKey(form, key: key);

      for (final file in data.files) {
        final path = '../../generated/${file.dir ?? ''}/${file.name}';

        File(path)
          ..createOrOverwriteSync(recursive: true)
          ..writeAsStringSync(file.contents);
      }
    } //
    catch (e) {
      stderr.writeln(e);
    }
  }
}
