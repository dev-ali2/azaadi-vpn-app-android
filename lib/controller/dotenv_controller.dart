import 'package:flutter_dotenv/flutter_dotenv.dart';

class DotenvController {
  static Future<void> initDotenv() async {
    await dotenv.load(fileName: ".env");
  }
}
