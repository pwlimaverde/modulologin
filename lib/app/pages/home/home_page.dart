import 'package:flutter/material.dart';
import 'package:modulologin/app/app_module.dart';
import 'package:modulologin/app/shared/mod_login/mod_login_bloc.dart';
import 'package:modulologin/app/shared/mod_login/mod_login_page.dart';
import 'package:modulologin/app/shared/mod_login/model/mod_login_model.dart';
import 'package:modulologin/app/shared/mod_login/utilitario/rotas_login.dart';

final modLoginBloc = AppModule.to.getBloc<ModLoginBloc>();
final ModLoginModel model = modLoginBloc.model;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: <Widget>[
            FutureBuilder(
                    future: getData(),
                    builder: (context, snapshot) {
                        if (snapshot.hasError) {
                            print("Tem erro");
                            return RaisedButton(
                                    color: Theme.of(context).primaryColor,
                                    textColor: Colors.white,
                                    child: Text("Login"),
                                    onPressed: () {
                                        navLoginPage(context);
                                    });
                        }
                        if (!snapshot.hasData) {
                            print("Não tem dados");
                            return RaisedButton(
                                    color: Theme.of(context).primaryColor,
                                    textColor: Colors.white,
                                    child: Text("Login"),
                                    onPressed: () {
                                        navLoginPage(context);
                                    });
                        }
                        return getTxt(context);
                    }),
        ],
      ),
      body: Column(
        children: <Widget>[
        ],
      ),
    );
  }
}

getTxt(context) {
  try {
    return StreamBuilder<List<ModLoginModel>>(
        stream: modLoginBloc.usersListOut,
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
                Container(
                  width: 10,
                ),
                Text("Bem vindo ${model[0].username}"),
                Container(
                  width: 10,
                ),
                buttonLogout(context),
              ],
            );
          } catch (e) {
            return RaisedButton(
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                child: Text("Login"),
                onPressed: () {
                  navLoginPage(context);
                });
          }
        });
  } catch (e) {
    return RaisedButton(
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        child: Text("Login"),
        onPressed: () {
          navLoginPage(context);
        });
  }
}

getData() async {
  var login = await model.username;
  return login;
}

