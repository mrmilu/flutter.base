import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_base/setup.dart';

void main() async {
  await dotenv.load(fileName: ".env.beta");
  startApp();
}
