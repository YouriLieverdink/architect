import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:cli/cli.dart';
import 'package:collection/collection.dart';

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
      final json = await File('../../assets/form.json').readAsJson();
      final form = IoApibuilderGeneratorV0ModelsInvocationForm.fromJson(json);

      final data = await client.invocations.postByKey(form, key: key);

      // Output the files.
      for (final file in data.files) {
        final path = './generated/${file.dir ?? ''}/${file.name}';

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
