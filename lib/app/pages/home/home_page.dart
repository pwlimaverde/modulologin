import 'package:flutter/material.dart';
import 'package:modulologin/app/app_module.dart';
import 'package:modulologin/app/shared/mod_login/mod_login_bloc.dart';
import 'package:modulologin/app/shared/mod_login/model/mod_login_model.dart';

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
            modLoginBloc.buttonLoginA(),
        ],
      ),
      body: Column(
        children: <Widget>[
        ],
      ),
    );
  }
}

