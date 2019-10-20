import 'package:flutter_test/flutter_test.dart';

import 'package:modulologin/app/shared/bloc/user_bloc.dart';

void main() {
  UserBloc bloc;

  setUp(() {
    bloc = UserBloc();
  });

  group('UserBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<UserBloc>());
    });
  });
}
