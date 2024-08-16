import 'package:faker_dart/faker_dart.dart';

extension FakerExtension on Faker {
  String frontMock(String text) {
    return fake('[FRONT] $text');
  }

  String email() {
    return fake(
      '${name.firstName()}.${name.lastName()}@${internet.domainName()}.${internet.domainSuffix()}',
    );
  }

  T singleListOption<T>(List<T> list) {
    return list[datatype.number(max: list.length)];
  }
}
