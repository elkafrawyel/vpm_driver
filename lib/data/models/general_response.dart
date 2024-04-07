class GeneralResponse {
  GeneralResponse({
    this.message = '',
  });

  GeneralResponse.fromJson(dynamic json) {
    message = json['message'] ?? '';
  }

  String message = '';
}
