import 'package:flutter_test/flutter_test.dart';

import 'package:modulologin/app/shared/mod_login/mod_login_bloc.dart';

void main() {
  ModLoginBloc bloc;

  setUp(() {
    bloc = ModLoginBloc();
  });

  group('ModLoginBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<ModLoginBloc>());
    });
  });
}
