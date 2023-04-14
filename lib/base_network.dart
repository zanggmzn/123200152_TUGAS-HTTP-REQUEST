import 'dart:convert';
import 'package:http/http.dart' as http;
//kelas untuk membentuk link req dari API
class BaseNetwork {
  static final String baseUrl = "https://reqres.in/api";

  //future data yg blm pasti, dia asinkronus fungsi jadi bisa berjalan bersamaan alias ga hrus urut
  static Future<Map<String, dynamic>> get(String partUrl) async {
    final String fullUrl = baseUrl + "/" + partUrl;

    debugPrint("BaseNetwork - fullUrl : $fullUrl");

    // method get utk req isi dari API dari base URL
    final response = await http.get(Uri.parse(fullUrl));

    //tulis hasil debug di method ke konsol
    debugPrint("BaseNetwork - response : ${response.body}");

    //respon akan dikirim ke method processResponse
    return _processResponse(response);
  }

  static Future<Map<String, dynamic>> _processResponse(
    //cek respon yyg bentuknya json
      http.Response response) async {
    final body = response.body;
    if (body.isNotEmpty) {
      final jsonBody = json.decode(body);
      return jsonBody;
    } else {
      print("processResponse error");
      return {"error": true};
    }
  }

  static void debugPrint(String value) {
    print("[BASE_NETWORK] - $value");
  }
}
