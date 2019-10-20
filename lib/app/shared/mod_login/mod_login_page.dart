import 'package:flutter/material.dart';
import 'package:modulologin/app/app_module.dart';
import 'package:modulologin/app/shared/mod_login/mod_login_bloc.dart';


final modLoginBloc = AppModule.to.getBloc<ModLoginBloc>();


class ModLoginPage extends StatefulWidget {
  @override
  _ModLoginPageState createState() => _ModLoginPageState();
}

class _ModLoginPageState extends State<ModLoginPage> {
  @override
  Widget build(BuildContext context) {
    return modLoginBloc.widgetLogin(context);
  }
}
