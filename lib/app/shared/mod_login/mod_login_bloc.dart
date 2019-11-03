import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:modulologin/app/shared/mod_login/mod_login_repository.dart';
import 'package:modulologin/app/shared/mod_login/utilitario/alert.dart';
import 'package:modulologin/app/shared/mod_login/utilitario/estilos.dart';
import 'package:modulologin/app/shared/mod_login/utilitario/rotas_login.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ModLoginBloc extends BlocBase {
  final _formKey = GlobalKey<FormState>();
  final _crtlLogin = TextEditingController();
  final _crtlSenha = TextEditingController();
  final storage = FlutterSecureStorage();

  BehaviorSubject<String> _usersListController = BehaviorSubject.seeded(null);
  Observable<String> get usersListOut => _usersListController.stream;

  addNovoLogin(String user) {
    _usersListController.add(user);
    _usersListController.add(_usersListController.value);
  }

  void _logout() async {
    await storage.deleteAll();
    _usersListController.add(null);
  }

  _getData() async {
    String login = await storage.read(key: "username");
    return login;
  }

  _loginButton(context) {
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
        Container(
          height: 10,
          width: 10,
        ),
      ],
    );
  }

  _logoutButton(user){
    return Row(
      children: <Widget>[
        Icon(Icons.account_box),
        Container(
          height: 10,
          width: 10,
        ),
        Text("Bem vindo $user"),
        Center(
          child: IconButton(
            icon: Icon(Icons.input),
            onPressed: () {
              _logout();
            },
          ),
        ),
        Container(
          height: 10,
          width: 10,
        ),
      ],
    );
  }

  buttonLogin() {
    return FutureBuilder(
        future: _getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("condição 1 - tem erro");
            return _loginButton(context);
          }
          if (!snapshot.hasData) {
            print("condição 2 - não tem dados");
            return _loginButton(context);
          }
          print("condição 3 - tem dados");
          return _getOkB(context);
        });
  }

  _getOkB(context) {
    return StreamBuilder<String>(
            stream: usersListOut,
            builder: (context, snapshot) {
              final user = snapshot.data;
              if (snapshot.hasData) {
                print("condição ok - stream tem data");
                return _logoutButton(user);
              }
              print("condição errada - stream sem data");
              return _loginButton(context);
            });
  }

  widgetLogin(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Acesso"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(40),
            child: Container(
              width: 350,
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

    var usuarioLogado = await LoginApi.loginUsers(context, username, password);
    if (usuarioLogado != null) {
      print("logou");
      Navigator.pop(context);
      navHomePage(context);
    } else {
      alertLogin(context, "Login Inválido");
    }
  }


  @override
  void dispose() {
    super.dispose();
  }
}
