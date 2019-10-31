import 'package:flutter/material.dart';
import 'package:modulologin/app/app_module.dart';
import 'package:modulologin/app/shared/mod_login/mod_login_bloc.dart';

final modLoginBloc = AppModule.to.getBloc<ModLoginBloc>();

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
            modLoginBloc.buttonLogin(),
        ],
      ),
      body: Column(
        children: <Widget>[
        ],
      ),
    );
  }
}

