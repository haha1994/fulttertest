import 'dart:convert';

class HttpUtil {

  String getBasicAuth(String username, String password) {
    String base64 = base64Encode(utf8.encode("$username:$password"));
    String basicAuth = "Basic $base64";
    return basicAuth;
  }

}