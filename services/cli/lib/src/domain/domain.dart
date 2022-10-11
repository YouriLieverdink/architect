import 'package:cli/cli.dart';
import 'package:http/http.dart' as http;

final client = Client(
  client: http.Client(),
  baseUrl: 'http://localhost:8000',
);
