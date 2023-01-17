import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/shared/network/server_gate.dart';
import 'event.dart';
import 'state.dart';

class ForgetPasswordInBloc
    extends Bloc<ForgetPasswordEvents, ForgetPasswordStates> {
  ServerGate serverGate = ServerGate();
  // final formKey = GlobalKey<FormState>();
  // final passwordController = TextEditingController();
  // final phoneController = TextEditingController();

  ForgetPasswordInBloc() : super((ForgetPasswordInitialState())) {
    on<ForgetPasswordPostEvent>(_postForgetPasswordIn);
  }

  Future<void> _postForgetPasswordIn(
      ForgetPasswordPostEvent event, Emitter<ForgetPasswordStates> emit) async {
    emit(ForgetPasswordLoadingState());
    try {
      final resp = await serverGate.sendToServer(
          url: 'forget-password-send-code', body: event.body);
      if (resp.success) {
        /* final model = UserDataModel.fromJson(resp.response?.data?["data"]??{});*/

        /* CacheHelper.setUserToken(model.token);*/
        if (resp.response?.data["key"] == "fail") {
          emit(ForgetPasswordErrorState(resp.response?.data["msg"]));
        } else {
          // final model = UserDataModel.fromJson(resp.response?.data?["data"]??{});
          emit(ForgetPasswordSuccessState(resp.msg));
        }

        // print("XOXOXOXOXOXOXXOXOXXOXOXOXXOXOXO ${CacheHelper.getUserToken()}");

      } else {
        emit(ForgetPasswordErrorState(resp.msg));
      }
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ForgetPasswordErrorState(error.toString()));
    }
  }
}
