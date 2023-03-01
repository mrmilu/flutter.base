class Environments {
  static const dev = 'dev';
  static const test = 'test';
  static const beta = 'beta';
  static const live = 'live';
}

const List<String> localEnvironment = [Environments.dev];
const List<String> testEnvironment = [Environments.test];
const List<String> onlineEnvironment = [Environments.beta, Environments.live];
