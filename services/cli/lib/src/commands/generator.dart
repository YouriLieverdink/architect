import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:cli/cli.dart';
import 'package:collection/collection.dart';

class GeneratorCommand extends Command {
  //
  GeneratorCommand() {
    addSubcommand(GeneratorListCommand());
    addSubcommand(GeneratorGetCommand());
  }

  @override
  String get name => 'generator';

  @override
  String get description => 'List all and individual generators.';

  @override
  Future<void> run() async {}
}

class GeneratorListCommand extends Command {
  //
  GeneratorListCommand();

  @override
  String get name => 'list';

  @override
  String get description => 'Lists all the available generators.';

  @override
  Future<void> run() async {
    try {
      final data = await client.generators.get();

      for (final v in data) {
        stdout.writeln(v.toJson());
      }
    } //
    catch (e) {
      stderr.writeln(e);
    }
  }
}

class GeneratorGetCommand extends Command {
  //
  GeneratorGetCommand();

  @override
  String get name => 'get';

  @override
  String get description => 'Retrieves one specific generator by key.';

  @override
  Future<void> run() async {
    final key = argResults?.rest.firstOrNull;

    if (key == null) {
      throw UsageException('Missing key for "dev generator get <key>"', usage);
    }

    try {
      final data = await client.generators.getByKey(key: key);

      stdout.writeln(data.toJson());
    } //
    catch (e) {
      stderr.writeln(e);
    }
  }
}
