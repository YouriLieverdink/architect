import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:cli/cli.dart';

class HealthcheckCommand extends Command {
  //
  HealthcheckCommand() {
    addSubcommand(HealthcheckGetCommand());
  }

  @override
  String get name => 'healthcheck';

  @override
  String get description => 'Health of the service.';
}

class HealthcheckGetCommand extends Command {
  //
  HealthcheckGetCommand();

  @override
  String get name => 'get';

  @override
  String get description => 'Gets the latest health information.';

  @override
  Future<void> run() async {
    try {
      final data = await client.healthchecks.get();

      stdout.writeln(data.toJson());
    } //
    catch (e) {
      stderr.writeln(e);
    }
  }
}
