import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:modulologin/app/pages/login/login_bloc.dart';
import 'package:modulologin/app/pages/login/login_module.dart';
import 'package:modulologin/app/pages/login/model/login_model.dart';
import 'package:modulologin/shared/constants.dart';

final loginBloc = LoginModule.to.getBloc<LoginBloc>();
var model = loginBloc.model;

class LoginRepository extends Disposable {
  Future fetchPost(Dio client) async {
    final response =
        await client.get('https://jsonplaceholder.typicode.com/posts/1');
    return response.data;
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}

class LoginApi {
  static Future<LoginModel> loginUsers(String username, String password) async {

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
      loginBloc.addNovoLogin(model);
      print(model);
    } else {
      model = null;
    }
    return model;
  }
}
