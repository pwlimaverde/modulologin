import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:modulologin/app/app_module.dart';
import 'package:modulologin/app/shared/mod_login/mod_login_bloc.dart';
import 'package:modulologin/app/shared/mod_login/utilitario/constants.dart';
import 'package:modulologin/app/shared/mod_login/utilitario/alert.dart';


final modLoginBloc = AppModule.to.getBloc<ModLoginBloc>();


class LoginApi {
  static Future<String> loginUsers(context, String username, String password) async {
    alertProgress(context, "Aguarde");
    var userLogado;
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

    if (response.statusCode == 200) {
      await modLoginBloc.storage.write(key: "token", value: mapResponse["token"]);
      await modLoginBloc.storage.write(key: "username", value: params["username"]);
      await modLoginBloc.storage.write(key: "password", value: params["password"]);
      modLoginBloc.addNovoLogin(await modLoginBloc.storage.read(key: "username"));
      userLogado = await modLoginBloc.storage.read(key: "username");
    } else {
      userLogado = null;
    }
    Navigator.pop(context);
    return userLogado;
  }

  @override
  void dispose() {
  LoginApi().dispose();
  }
}
