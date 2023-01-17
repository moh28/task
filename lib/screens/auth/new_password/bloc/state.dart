
class ResedPasswordStates {}

class ResedPasswordInitialState extends ResedPasswordStates {}

class ResedPasswordLoadingState extends ResedPasswordStates {}

class ResedPasswordSuccessState extends ResedPasswordStates {
  final String msg;

  ResedPasswordSuccessState(this.msg);
}

class ResedPasswordErrorState extends ResedPasswordStates {
  final String msg;

  ResedPasswordErrorState(this.msg);
}