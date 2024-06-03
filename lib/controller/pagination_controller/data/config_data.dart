class ConfigData<T> {
  String apiEndPoint;
  String emptyListMessage;
  T Function(dynamic) fromJson;
  Map<String, dynamic>? parameters;

  ConfigData({
    required this.apiEndPoint,
    this.emptyListMessage = 'Empty Data',
    required this.fromJson,
    this.parameters,
  });
}
