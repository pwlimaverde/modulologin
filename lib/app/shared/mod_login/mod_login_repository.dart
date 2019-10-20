import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:modulologin/app/app_module.dart';
import 'package:modulologin/app/shared/mod_login/mod_login_bloc.dart';
import 'package:modulologin/app/shared/mod_login/model/mod_login_model.dart';
import 'package:modulologin/app/shared/mod_login/utilitario/constants.dart';


final modLoginBloc = AppModule.to.getBloc<ModLoginBloc>();
var model = modLoginBloc.model;

//class ModLoginRepository extends Disposable {
//  Future fetchPost(Dio client) async {
//    final response =
//        await client.get('https://jsonplaceholder.typicode.com/posts/1');
//    return response.data;
//  }
//
//  @override
//  void dispose() {}
//}

class LoginApi {
  static Future<ModLoginModel> loginUsers(String username, String password) async {

    var url = BASE_URL;
    var urlToken = TOKEN_URL;
    var header = {
      "Content-type": "application/json",
    };
    Map params = {
      "username": username,
      "password": password,
    };
    var _body = json.encode(params);

    var response = await http.post(url+urlToken, headers: header, body: _body);
    Map mapResponse = json.decode(response.body);
    print(response.body);

    if (response.statusCode == 200) {
      model.username = params["username"];
      model.password = params["password"];
      model.token = mapResponse["token"];
      modLoginBloc.addNovoLogin(model);
      print(model);
    } else {
      model = null;
    }
    return model;
  }

  @override
  void dispose() {

  }
}
