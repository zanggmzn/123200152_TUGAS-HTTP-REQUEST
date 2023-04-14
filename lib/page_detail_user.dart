import 'package:flutter/material.dart';
import 'package:pt6_prakttpm/api_datasource.dart';
import 'package:pt6_prakttpm/detail_user_model.dart';

class PageDetailUser extends StatelessWidget {
  final int idUser;
  const PageDetailUser({Key? key, required this.idUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail User $idUser'),
      ),
      body: Container(
        child: FutureBuilder(
          //future builder ini yg bentuk hasl future nya
          future: ApiDataSource.instance
              .loadDetailUser(idUser), //data future diambil dr si apidatasource
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            //cek hasil request
            if (snapshot.hasError) {
              // Jika data ada error maka akan ditampilkan hasil error
              return const Text('Error');
            }
            if (snapshot.hasData) {
              // Jika data ada dan berhasil maka akan ditampilkan hasil datanya
              DetailUsersModel usersModel = DetailUsersModel.fromJson(
                  snapshot.data); //nambahin data kalo berhasil
              return _buildSuccessSection(context, usersModel);
            }
            //dijalanain pas API sdg dipanggil
            return _buildLoadingSection(); //default nya pas nunggu ambil data
          },
        ),
      ),
    );
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(), //widget buat nampilin yg loding
    );
  }

  // Widget _buildSuccessSection(DetailUsersModel users) {
  //   return ListView.builder(
  //     itemBuilder: (BuildContext context, int index) {
  //       //ternyata disini dia masuk ke widget buildItemUsers dibawah nya
  //       return _buildItemUsers(context, users.data!); // keadaan waktu commandnya sukses
  //     },
  //   );
  // }

  Widget _buildSuccessSection(BuildContext context, DetailUsersModel users) {
    final userData = users.data!;
    return Container(
      child: _buildItemUsers(context, userData),
    );
  }

  Widget _buildItemUsers(BuildContext context, Data userData) {
    return Container(
      child: Center(
        child: Column(children: [
          Container(
            width: 100,
            child: Image.network(userData.avatar!),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(userData.firstName! + " " + userData.lastName!),
              Text(userData.email!)
            ],
          )
        ]),
      ),
    );
  }
}
