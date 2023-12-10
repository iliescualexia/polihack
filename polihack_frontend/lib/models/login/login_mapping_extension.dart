import 'login_credential_model.dart';

extension LoginMappingExtension on LoginCredentialsModel{

  Map<String, String> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}