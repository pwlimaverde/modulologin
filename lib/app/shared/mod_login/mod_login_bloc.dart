import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:modulologin/app/shared/mod_login/model/mod_login_model.dart';
import 'package:modulologin/app/shared/mod_login/utilitario/rotas_login.dart';
import 'package:rxdart/rxdart.dart';

class ModLoginBloc extends BlocBase {
  final ModLoginModel model = ModLoginModel();

  BehaviorSubject<List<ModLoginModel>> _usersListController =
      BehaviorSubject.seeded([]);
  Observable<List<ModLoginModel>> get usersListOut =>
      _usersListController.stream;

  addNovoLogin(ModLoginModel model) {
    _usersListController.value.add(model);
    _usersListController.add(_usersListController.value);
  }

  void logout() {
    _usersListController.add([]);
    model.token = null;
    model.username = null;
    model.password = null;
  }

  buttonLoginA() {
    return FutureBuilder(
        future: _getDataA(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Row(
              children: <Widget>[
                Center(
                  child: IconButton(
                    icon: Icon(Icons.people),
                    onPressed: () {
                      navLoginPage(context);
                    },
                  ),
                ),
                Center(child: Text("Login")),
                Container(
                  height: 10,
                ),
              ],
            );
          }
          if (!snapshot.hasData) {
            return Row(
              children: <Widget>[
                Center(
                  child: IconButton(
                    icon: Icon(Icons.people),
                    onPressed: () {
                      navLoginPage(context);
                    },
                  ),
                ),
                Center(child: Text("Login")),
                Container(
                  height: 10,
                  width: 10,
                ),
              ],
            );
          }
          return _getOkA(context);
        });
  }

  _getOkA(context) {
    try {
      return StreamBuilder<List<ModLoginModel>>(
          stream: usersListOut,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return CircularProgressIndicator();
            }
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            final List<ModLoginModel> model = snapshot.data;
            try {
              return Row(
                children: <Widget>[
                  Icon(Icons.account_box),
                  Text("Bem vindo ${model[0].username}"),
                  Center(
                    child: IconButton(
                      icon: Icon(Icons.input),
                      onPressed: () {
                        logout();
                      },
                    ),
                  ),
                  Container(
                    height: 10,
                    width: 10,
                  ),
                ],
              );
            } catch (e) {
              return Row(
                children: <Widget>[
                  Center(
                    child: IconButton(
                      icon: Icon(Icons.people),
                      onPressed: () {
                        navLoginPage(context);
                      },
                    ),
                  ),
                  Center(child: Text("Login")),
                  Container(
                    height: 10,
                  ),
                ],
              );
            }
          });
    } catch (e) {
      return Row(
        children: <Widget>[
          Center(
            child: IconButton(
              icon: Icon(Icons.people),
              onPressed: () {
                navLoginPage(context);
              },
            ),
          ),
          Center(child: Text("Login")),
          Container(
            height: 10,
          ),
        ],
      );
    }
  }

  _getDataA() async {
    var login = await model.username;
    return login;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
