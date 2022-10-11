import 'package:orchestrator/orchestrator.dart' as i1;

Iterable<i1.Docs> buildHeader(
  String name,
) sync* {
  //
  const apibuilder = 'https://www.apibuilder.io/';

  yield const i1.Docs(
    'This file is generated using Apibuilder - $apibuilder',
  );

  yield const i1.Docs('');

  const github = 'https://github.com/iruoy-nl/builders/';

  yield i1.Docs(
    'The generator that is responsible for this is `$name` and can be found on '
    'Github at $github.',
  );
}
