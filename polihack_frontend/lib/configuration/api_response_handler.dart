import 'dart:convert';

class APIResponseHandler {
  final responseBody;
  APIResponseHandler(this.responseBody);

  Map<String, dynamic> parseBody() {
    return jsonDecode(responseBody);
  }

  static bool hasErrors(Map<String, dynamic> body) {
    if (body['errors'] != null && !body['errors'].isEmpty) {
      if (body['errors'].length == 1 && body['errors'][0] == "Please enter multi-factor code sent on email") {
        return false;
      }
      return true;
    }
    return false;
  }

  static dynamic getData(Map<String, dynamic> body) {
    if (!hasErrors(body)) {
      return body['object'];
    } else {
      List<dynamic> errors = body['errors'];
      return errors.map((error) => error['errorMessage'] as String).join('\n');
    }
  }
}
