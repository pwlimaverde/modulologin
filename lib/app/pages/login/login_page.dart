import 'package:flutter/material.dart';
import 'package:modulologin/app/pages/login/login_bloc.dart';
import 'package:modulologin/app/pages/login/login_module.dart';
import 'package:modulologin/app/pages/login/login_repository.dart';
import 'package:modulologin/shared/estilos.dart';
import 'package:modulologin/shared/rotas.dart';

final loginBloc = LoginModule.to.bloc<LoginBloc>();
final loginModel = loginBloc.model;

final _formKey = GlobalKey<FormState>();
final _crtlLogin = TextEditingController();
final _crtlSenha = TextEditingController();

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
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
                loginField(context, style),
                SizedBox(
                  height: 40,
                ),
                confirmeLogin(context, style),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

loginField(context, style) {
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

confirmeLogin(context, style) {
  return ButtonTheme(
    minWidth: MediaQuery.of(context).size.width,
    padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
    child: RaisedButton(
      color: Theme.of(context).primaryColor,
      child: Text("Login",
          textAlign: TextAlign.center,
          style:
              style.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
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

alert(BuildContext context, String msg) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Login"),
          content: Text(msg),
          actions: <Widget>[
            FlatButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        );
      });
}

buttonLogin(context) {
  return RaisedButton(
      color: Theme.of(context).primaryColor,
      textColor: Colors.white,
      child: Row(
        children: <Widget>[
          Container(
            width: 10,
          ),
          Container(
            height: 20,
            child: Image.asset("imagens/iconlogin.png", fit: BoxFit.contain),
          ),
          Container(
            width: 10,
          ),
          Container(height: 20, child: Text("Fazer Login")),
          Container(
            width: 10,
          ),
        ],
      ),
      onPressed: () {
        print("clicou");
        navLoginPage(context);
      });
}

buttonLogout(context) {
  return RaisedButton(
      color: Theme.of(context).primaryColor,
      textColor: Colors.white,
      child: Row(
        children: <Widget>[
          Container(
            width: 10,
          ),
          Icon(Icons.input),
          Container(
            width: 10,
          ),
          Text("Logout"),
          Container(
            width: 10,
          ),
        ],
      ),
      onPressed: () {
        print("clicou");
        loginBloc.logout();
      });
}
