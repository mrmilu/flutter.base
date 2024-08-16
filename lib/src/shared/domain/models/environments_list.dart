class Environments {
  static const dev = 'dev';
  static const test = 'test';
  static const beta = 'beta';
  static const live = 'live';
}

const List<String> localEnvironment = [
  Environments.dev,
  Environments.beta,
];
const List<String> testEnvironment = [Environments.test];
const List<String> onlineEnvironment = [Environments.live];
const List<String> noTestEnvironment = [
  Environments.dev,
  Environments.beta,
  Environments.live,
];
