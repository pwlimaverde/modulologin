import 'package:flutter/material.dart';
import 'package:modulologin/app/pages/home/home_module.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Slidy',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: HomeModule(),
    );
  }
}
