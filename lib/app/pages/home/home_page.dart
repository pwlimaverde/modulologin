import 'package:flutter/material.dart';
import 'package:modulologin/app/app_module.dart';
import 'package:modulologin/app/pages/login/model/login_model.dart';
import 'package:modulologin/app/shared/bloc/user_bloc.dart';
import 'package:modulologin/app/shared/rotas.dart';


final loginBloc = AppModule.to.getBloc<UserBloc>();
final LoginModel model = loginBloc.model;

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
      ),
      body: Column(
        children: <Widget>[
          Icon(Icons.dashboard),
          RaisedButton(
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  child: Text("Login"),
                  onPressed: () {
                    navLoginPage(context);
                  }),
          RaisedButton(
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  child: Text("Logout"),
                  onPressed: () {
                    loginBloc.logout();
                  }),
          Column(
            children: <Widget>[
              FutureBuilder(
                future: getData(),
                builder: (context, snapshot){
                  if(snapshot.hasError){
                    return Text("Tem erro Future");
                  }
                  if(!snapshot.hasData){
                    print("Não tem dados futuro");
                    return RaisedButton(
                            color: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                            child: Text("Login"),
                            onPressed: () {
                              navLoginPage(context);
                            });
                  }
                  return getTxt(context);
                }
              ),
            ],
          ),
        ],
      ),
    );
  }
}

getTxt(context){
  try{
    return StreamBuilder<List<LoginModel>>(
      stream: loginBloc.usersListOut,
      builder: (context, snapshot) {
        if(snapshot.hasError){
          print(snapshot.data);
          print("erro");
          return CircularProgressIndicator();
        }
        if(!snapshot.hasData){
          print(snapshot.data);
          print("Não tem dados");
          return CircularProgressIndicator();
        }
        final List<LoginModel> model = snapshot.data;
        try{
          return Text("O token é ${model[0].token}");
        }catch(e){
          return Text("não está logado");
        }
      }
    );
  }catch(e){
    return Text("Não está logado");
  }
}

getData() async {
  var login = await model.username;
  return login;
}

