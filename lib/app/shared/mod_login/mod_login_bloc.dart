import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:modulologin/app/shared/mod_login/mod_login_repository.dart';
import 'package:modulologin/app/shared/mod_login/model/mod_login_model.dart';
import 'package:modulologin/app/shared/mod_login/utilitario/alert.dart';
import 'package:modulologin/app/shared/mod_login/utilitario/estilos.dart';
import 'package:modulologin/app/shared/mod_login/utilitario/rotas_login.dart';
import 'package:rxdart/rxdart.dart';

class ModLoginBloc extends BlocBase {
  final ModLoginModel model = ModLoginModel();
  final _formKey = GlobalKey<FormState>();
  final _crtlLogin = TextEditingController();
  final _crtlSenha = TextEditingController();

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

  widgetLogin(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Acesso"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
//            color: Colors.white,
            padding: const EdgeInsets.all(40),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 100,
                  child:
                      Image.asset("imagens/iconlogin.png", fit: BoxFit.contain),
                ),
                SizedBox(
                  height: 40,
                ),
                _loginField(context, style),
                SizedBox(
                  height: 40,
                ),
                _confirmeLogin(context, style),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _loginField(context, style) {
    return Form(
      key: _formKey,
      child: Column(children: <Widget>[
        _textFormField(
          style,
          "Login",
          "Digit o Login",
          controller: _crtlLogin,
          validator: _validaLogin,
        ),
        Container(
          height: 20,
        ),
        _textFormField(
          style,
          "Senha",
          "Digit a Senha",
          senha: true,
          controller: _crtlSenha,
          validator: _validaSenha,
        ),
      ]),
    );
  }

  _confirmeLogin(context, style) {
    return ButtonTheme(
      minWidth: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
      child: RaisedButton(
        color: Theme.of(context).primaryColor,
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        onPressed: () {
          _clicButton(context);
        },
      ),
    );
  }

  String _validaLogin(String texto) {
    if (texto.isEmpty) {
      return "Digite o Login";
    }
    return null;
  }

  String _validaSenha(String texto) {
    if (texto.isEmpty) {
      return "Digite a Senha";
    }
    return null;
  }

  _textFormField(
    style,
    String label,
    String hint, {
    bool senha = false,
    TextEditingController controller,
    FormFieldValidator<String> validator,
  }) {
    return TextFormField(
      style: style,
      obscureText: senha,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }

  Future<void> _clicButton(BuildContext context) async {
    bool formOk = _formKey.currentState.validate();
    if (!formOk) {
      return;
    }

    String username = _crtlLogin.text;
    String password = _crtlSenha.text;

    var usuarioLogado = await LoginApi.loginUsers(username, password);
    if (usuarioLogado != null) {
      print("logou");
      Navigator.pop(context);
      navHomePage(context);
    } else {
      alert(context, "Login Inválido");
    }
  }

//  _buttonLogin(context) {
//    return RaisedButton(
//        color: Theme.of(context).primaryColor,
//        textColor: Colors.white,
//        child: Row(
//          children: <Widget>[
//            Container(
//              width: 10,
//            ),
//            Container(
//              height: 20,
//              child: Image.asset("imagens/iconlogin.png", fit: BoxFit.contain),
//            ),
//            Container(
//              width: 10,
//            ),
//            Container(height: 20, child: Text("Fazer Login")),
//            Container(
//              width: 10,
//            ),
//          ],
//        ),
//        onPressed: () {
//          print("clicou");
//          navLoginPage(context);
//        });
//  }
//
//  _buttonLogout(context) {
//    return RaisedButton(
//        color: Theme.of(context).primaryColor,
//        textColor: Colors.white,
//        child: Row(
//          children: <Widget>[
//            Container(
//              width: 10,
//            ),
//            Icon(Icons.input),
//            Container(
//              width: 10,
//            ),
//            Text("Logout"),
//            Container(
//              width: 10,
//            ),
//          ],
//        ),
//        onPressed: () {
//          print("clicou");
//          modLoginBloc.logout();
//        });
//  }

  @override
  void dispose() {
    super.dispose();
  }
}
