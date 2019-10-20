import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:modulologin/app/shared/mod_login/model/mod_login_model.dart';
import 'package:rxdart/rxdart.dart';

class ModLoginBloc extends BlocBase {

  final ModLoginModel model = ModLoginModel();

  BehaviorSubject<List<ModLoginModel>> _usersListController = BehaviorSubject.seeded([]);
  Observable<List<ModLoginModel>> get usersListOut => _usersListController.stream;

  addNovoLogin(ModLoginModel model){
    _usersListController.value.add(model);
    _usersListController.add(_usersListController.value);
  }

  void logout(){
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
