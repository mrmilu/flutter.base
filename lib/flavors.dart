enum Flavor {
  beta,
  live,
}

class F {
  static late final Flavor appFlavor;

  static String get name => appFlavor.name;

  static String get title {
    switch (appFlavor) {
      case Flavor.beta:
        return 'FlutterBase (Beta)';
      case Flavor.live:
        return 'FlutterBase';
    }
  }

}
