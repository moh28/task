class ForgetPasswordStates {}

class ForgetPasswordInitialState extends ForgetPasswordStates {}

class ForgetPasswordLoadingState extends ForgetPasswordStates {}

class ForgetPasswordSuccessState extends ForgetPasswordStates {
  final String msg;

  ForgetPasswordSuccessState(this.msg);
}

class ForgetPasswordErrorState extends ForgetPasswordStates {
  final String msg;

  ForgetPasswordErrorState(this.msg);
}