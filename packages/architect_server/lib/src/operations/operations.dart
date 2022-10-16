import 'package:architect/architect.dart';
import 'package:architect_server/architect_server.dart';

export './generator/list_generators.dart';
export './generator/show_generator.dart';
export './healthcheck/show_healthcheck.dart';
export './invocation/add_invocation.dart';

const listGenerators = CreateListGenerators(generators);
const showGenerator = CreateShowGenerator(generators);
const showHealthcheck = CreateShowHealthcheck();
final addInvocation = CreateAddInvocation(showGenerator);
