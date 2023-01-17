class SignUpStates {}

class SignUpInitialState extends SignUpStates {}

class SignUpLoadingState extends SignUpStates {}

class SignUpSuccessState extends SignUpStates {
  final String msg;

  SignUpSuccessState(this.msg);
}

class SignUpErrorState extends SignUpStates {
  final String msg;

  SignUpErrorState(this.msg);
}