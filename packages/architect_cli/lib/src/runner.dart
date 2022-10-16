import 'dart:io';

import 'package:architect_cli/architect_cli.dart';
import 'package:args/command_runner.dart';

Future<void> commandRun(
  List<String> args,
) async {
  //
  final runner = CommandRunner('cli', 'Development cli for the Dart generator.')
    ..addCommand(GeneratorCommand())
    ..addCommand(HealthcheckCommand())
    ..addCommand(InvocationCommand());

  try {
    await runner.run(args);

    // Not closing the client would result in the Dart process not ending.
    client.client.close();
  } //
  on UsageException catch (e) {
    stderr.writeln(e);

    exit(64);
  }
}
