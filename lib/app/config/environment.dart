class Environment {
  static const AppMode appMode = AppMode.live;

  static url() {
    switch (appMode) {
      case AppMode.testing:
      case AppMode.staging:
        return 'https://back.vpmsystems.com/api/';
      case AppMode.live:
        return 'https://back.vpmsystems.com/api/';
    }
  }
}

enum AppMode {
  testing,
  staging,
  live,
}
