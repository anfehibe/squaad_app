import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String squaadUrl = dotenv.env['SQUAAD_URL'] ?? "";
  static String bearerToken = dotenv.env['BEARER_TOKEN'] ?? "";
}
