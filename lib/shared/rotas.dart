
import 'package:flutter/material.dart';
import 'package:modulologin/app/pages/home/home_module.dart';
import 'package:modulologin/app/pages/login/login_module.dart';

navLoginPage(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginModule()),
    );
}

navHomePage(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeModule()),
    );
}