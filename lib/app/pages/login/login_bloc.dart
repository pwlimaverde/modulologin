import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:modulologin/app/pages/login/model/login_model.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends BlocBase {
  //dispose will be called automatically by closing its streams
  final LoginModel model = LoginModel();

  BehaviorSubject<List<LoginModel>> _usersListController = BehaviorSubject.seeded([]);
  Observable<List<LoginModel>> get usersListOut => _usersListController.stream;


  addNovoLogin(LoginModel model){
    _usersListController.value.add(model);
    _usersListController.add(_usersListController.value);
  }

  logout(){
    _usersListController.add([]);
    model.token = null;
    model.username = null;
    model.password = null;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
