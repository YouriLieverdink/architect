import 'package:architect_server/architect_server.dart';

export './generator/list_generators.dart';
export './generator/show_generator.dart';
export './healthcheck/show_healthcheck.dart';
export './invocation/add_invocation.dart';

const listGenerators = CreateListGenerators([]);
const showGenerator = CreateShowGenerator([]);
const showHealthcheck = CreateShowHealthcheck();
final addInvocation = CreateAddInvocation(showGenerator);
