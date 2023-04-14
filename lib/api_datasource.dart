import 'base_network.dart';

class ApiDataSource {
  static ApiDataSource instance = ApiDataSource();

    //loadUsers utk kembalikan nilai dr class BaseNetwork dgn method get
    // lalu diisi dengan parameter users karena minta list user2 yg tersedia
    Future<Map<String, dynamic>> loadUsers() {
    return BaseNetwork.get("users");
  }

  //parameternya idDiterima
  Future<Map<String, dynamic>> loadDetailUser(int idDiterima){
    //ambil detail user beerdasar id user tsb
    String id = idDiterima.toString();
    return BaseNetwork.get("users/$id");
  }
 
}