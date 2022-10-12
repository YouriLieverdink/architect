import 'package:server/server.dart';

export './generator/list_generators.dart';
export './generator/show_generator.dart';
export './healthcheck/show_healthcheck.dart';
export './invocation/add_invocation.dart';

final listGenerators = CreateListGenerators(generators);
final showGenerator = CreateShowGenerator(generators);

const showHealthcheck = CreateShowHealthcheck();

final addInvocation = CreateAddInvocation(showGenerator);
