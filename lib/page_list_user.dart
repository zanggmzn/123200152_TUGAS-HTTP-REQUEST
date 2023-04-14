import 'package:flutter/material.dart';
import 'package:pt6_prakttpm/api_datasource.dart';
import 'package:pt6_prakttpm/page_detail_user.dart';
import 'package:pt6_prakttpm/users_model.dart';

class PageListUsers extends StatelessWidget {
  const PageListUsers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List User'),
      ),
      body: _buildListUsersBody(),
    );
  }

  //widget untuk membentuk hasil future dari request API kita
  Widget _buildListUsersBody() {
    return Container(
      child: FutureBuilder(
        //future builder ini yg bentuk hasl future nya
        future: ApiDataSource.instance
            .loadUsers(), //data future diambil dr si apidatasource
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          //cek hasil request
          if (snapshot.hasError) {
            // Jika data ada error maka akan ditampilkan hasil error
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            // Jika data ada dan berhasil maka akan ditampilkan hasil datanya
            UsersModel usersModel = UsersModel.fromJson(
                snapshot.data); //nambahin data kalo berhasil
            return _buildSuccessSection(usersModel);
          }
          //dijalanain pas API sdg dipanggil
          return _buildLoadingSection(); //default nya pas nunggu ambil data
        },
      ),
    );
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(), //widget buat nampilin yg loding
    );
  }

  Widget _buildSuccessSection(UsersModel users) {
    return ListView.builder(
      itemCount: users.data!.length,
      itemBuilder: (BuildContext context, int index) {
        //ternyata disini dia masuk ke widget buildItemUsers dibawah nya
        return _buildItemUsers(context, users.data![index]); // keadaan waktu commandnya sukses
      },
    );
  }

  Widget _buildItemUsers(BuildContext context, Data userData) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PageDetailUser(idUser: userData.id!),
            ));
      },
      child: Card(
        child: Row(children: [
          Container(
            width: 100,
            child: Image.network(userData.avatar!),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
