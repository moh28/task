import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:task_2/screens/auth/login/bloc/event.dart';
import 'package:task_2/screens/auth/login/bloc/state.dart';

import '../../../../core/shared/helpers/cache_helper.dart';
import '../../../../core/shared/network/server_gate.dart';
import '../../../../models/user_data.dart';

class LogInBloc extends Bloc<LogInEvents, LogInStates> {
  ServerGate serverGate = ServerGate();
  // final formKey = GlobalKey<FormState>();
  // final passwordController = TextEditingController();
  // final phoneController = TextEditingController();

  LogInBloc() : super((LogInInitialState())) {
    on<LogInPostEvent>(_postLogIn);
  }

  Future<void> _postLogIn(
      LogInPostEvent event, Emitter<LogInStates> emit) async {
    emit(LogInLoadingState());
    try {
      final resp = await serverGate.sendToServer(
          url: 'sign-in?count_notifications', body: event.body);
      if (resp.success) {
        /* final model = UserDataModel.fromJson(resp.response?.data?["data"]??{});*/
        print('dattkdjkdkldl');
        print(resp.response?.data);
        /* CacheHelper.setUserToken(model.token);*/
        if (resp.response?.data["key"] == "fail") {
          emit(LogInErrorState(resp.response?.data["msg"]));
        } else {
          // final model = UserDataModel.fromJson(resp.response?.data?["data"]??{});
          CacheHelper.setUserToken(resp.response?.data?["data"]["token"]);
          emit(LogInSuccessState(resp.msg));
        }

        // print("XOXOXOXOXOXOXXOXOXXOXOXOXXOXOXO ${CacheHelper.getUserToken()}");

      } else {
        emit(LogInErrorState(resp.msg));
      }
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(LogInErrorState(error.toString()));
    }
  }
}
