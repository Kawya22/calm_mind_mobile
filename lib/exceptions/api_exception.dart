import 'package:http/http.dart';

class ApiException implements Exception {
  String message = "";

  ApiException(String? message, Response? response) {
    this.message = message ?? "Unknown Http Exception";

    if (response == null) return;

    this.message += "\nStatus Code: ${response.statusCode}";
    this.message += "\nBody: ${response.body}";
  }

  @override
  String toString() {
    return message;
  }
}
