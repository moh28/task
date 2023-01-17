import 'package:kiwi/kiwi.dart';

import '../../screens/auth/forget_password/bloc/bloc.dart';
import '../../screens/auth/login/bloc/bloc.dart';
import '../../screens/auth/new_password/bloc/bloc.dart';
import '../../screens/auth/register/bloc/bloc.dart';
import '../../screens/auth/verify_account/bloc/bloc.dart';

Future<void> initKiwi() async {
  KiwiContainer container = KiwiContainer();
  container.registerFactory((container) => LogInBloc());
  container.registerFactory((container) => SignUpBloc());
  container.registerFactory((container) => VerifyBloc());
  container.registerFactory((container) => ResendBloc());
  container.registerFactory((container) => ForgetPasswordInBloc());
  container.registerFactory((container) => ResedPasswordBloc());
  /*container.registerFactory((container) => RegisterBloc());
  container.registerFactory((container) => VerifyBloc());
  container.registerFactory((container) => ForgetPassWordBloc());
  container.registerFactory((container) => ActivatePasswordBloc());
  container.registerFactory((container) => NewPassWordBloc());
  container.registerFactory((container) => HomeBloc());
  container.registerFactory((container) => AccountBloc());*/
}
