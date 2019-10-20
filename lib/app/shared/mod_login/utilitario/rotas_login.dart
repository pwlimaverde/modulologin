import 'package:flutter/material.dart';
import 'package:modulologin/app/pages/home/home_module.dart';
import 'package:modulologin/app/shared/mod_login/mod_login_page.dart';

navLoginPage(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ModLoginPage()),
    );
}

navHomePage(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeModule()),
    );
}