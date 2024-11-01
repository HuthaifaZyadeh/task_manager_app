enum Flavor {
  dev,
  production,
}

class FlavorConfig {
  final Flavor flavor;
  final String baseUrl;

  FlavorConfig({
    required this.flavor,
    required this.baseUrl,
  });

  bool get isProduction => flavor == Flavor.production;

  bool get isDevelopment => flavor == Flavor.dev;
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'SimpleDo';
      case Flavor.production:
        return 'SimpleDo';
      default:
        return 'title';
    }
  }
}
