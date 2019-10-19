import 'package:flutter_test/flutter_test.dart';

import 'package:modulologin/app/pages/login/login_bloc.dart';

void main() {
  LoginBloc bloc;

  setUp(() {
    bloc = LoginBloc();
  });

  group('LoginBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<LoginBloc>());
    });
  });
}
