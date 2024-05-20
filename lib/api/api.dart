import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/constants.dart';

class Api {
  const Api._();

  static const instance = Api._();

  static final _fa = FirebaseAuth.instance;

  Future<http.Response> get(String url) async {
    if (!url.startsWith('/')) url = '/$url';

    final fullUrl = '$apiUrl$url';
    final headers = await _headers();
    return http.get(Uri.parse(fullUrl), headers: headers);
  }

  Future<Map<String, String>> _headers([contentJson = false]) async {
    final headers = <String, String>{};

    if (contentJson) {
      headers['Content-Type'] = 'application/json';
    }

    if (_fa.currentUser != null) {
      final token = await _fa.currentUser!.getIdToken();
      headers['Authorization'] = token!;
    }

    return headers;
  }
}
