
class VerifyStates {}

class VerifyInitialState extends VerifyStates {}

class VerifyLoadingState extends VerifyStates {}

class VerifySuccessState extends VerifyStates {
  final String msg;

  VerifySuccessState(this.msg);
}

class VerifyErrorState extends VerifyStates {
  final String msg;

  VerifyErrorState(this.msg);
}


class ResendStates {}

class ResendInitialState extends ResendStates {}

class ResendLoadingState extends ResendStates {}

class ResendSuccessState extends ResendStates {
  final String msg;

  ResendSuccessState(this.msg);
}

class ResendErrorState extends ResendStates {
  final String msg;

  ResendErrorState(this.msg);
}