import 'package:cli/cli.dart';
import 'package:http/http.dart';

final client = IoApibuilderGeneratorV0Client(
  client: Client(),
  baseUrl: 'http://localhost:8000',
);
