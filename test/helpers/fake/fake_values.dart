import 'package:faker_dart/faker_dart.dart';

final faker = Faker.instance;

final fakeName = faker.name.fullName();
final fakeEmail = faker.internet.email();
final fakePassword = faker.fake(
  '${faker.lorem.word(length: 1).toUpperCase()}${faker.lorem.word(length: 7).toLowerCase()}${faker.datatype.number()}',
);
final fakeToken = faker.datatype.uuid();
const fakeInvalidEmail = 'email';
const fakeInvalidPassword = 'password';
