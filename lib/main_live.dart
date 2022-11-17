import 'package:flutter_base/setup.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: '.env.live');
  startApp();
}
