import 'package:flutter/material.dart';
import 'package:modulologin/app/app_module.dart';
import 'package:modulologin/app/shared/mod_login/mod_login_bloc.dart';
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
            getButtonLogin(),
        ],
      ),
      body: Column(
        children: <Widget>[
        ],
      ),
    );
  }
}

getButtonLogin(){
    return FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
                if (snapshot.hasError) {
                    return Row(
                        children: <Widget>[
                            Center(
                                child: IconButton(
                                    icon: Icon(Icons.people),
                                    onPressed: (){navLoginPage(context);},
                                ),
                            ),
                            Center(child: Text("Login")),
                            Container(height: 10,),
                        ],
                    );
                }
                if (!snapshot.hasData) {
                    return Row(
                        children: <Widget>[
                            Center(
                                child: IconButton(
                                    icon: Icon(Icons.people),
                                    onPressed: (){navLoginPage(context);},
                                ),
                            ),
                            Center(child: Text("Login")),
                            Container(height: 10, width: 10,),
                        ],
                    );
                }
                return getTxt(context);
            });
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
                  Text("Bem vindo ${model[0].username}"),
                  Center(
                      child: IconButton(
                          icon: Icon(Icons.input),
                          onPressed: (){modLoginBloc.logout();},
                      ),
                  ),
                  Container(height: 10, width: 10,),
              ],
            );
          } catch (e) {
            return Row(
                children: <Widget>[
                    Center(
                        child: IconButton(
                            icon: Icon(Icons.people),
                            onPressed: (){navLoginPage(context);},
                        ),
                    ),
                    Center(child: Text("Login")),
                    Container(height: 10,),
                ],
            );
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

