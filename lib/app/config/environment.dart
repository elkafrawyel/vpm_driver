class Environment {
  static const AppMode appMode = AppMode.testing;

  static url() {
    switch (appMode) {
      case AppMode.testing:
      case AppMode.staging:
        return 'https://portal.profitsway.net/New_Parking/api/';
      case AppMode.live:
        return 'https://portal.profitsway.net/New_Parking/api/';
    }
  }
}

enum AppMode {
  testing,
  staging,
  live,
}
