import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:task_2/screens/auth/register/bloc/event.dart';
import 'package:task_2/screens/auth/register/bloc/state.dart';

import '../../../../core/shared/helpers/cache_helper.dart';
import '../../../../core/shared/network/server_gate.dart';

class SignUpBloc extends Bloc<SignUpEvents, SignUpStates> {
  ServerGate serverGate = ServerGate();
  final formKey = GlobalKey<FormState>();


  SignUpBloc() : super((SignUpInitialState())) {
    on<SignUpPostEvent>(_postSignUp);
  }

  Future<void> _postSignUp(
      SignUpPostEvent event, Emitter<SignUpStates> emit) async {
    emit(SignUpLoadingState());
    try {
      final resp =
          await serverGate.sendToServer(url: 'sign-up', body: event.body);
      if (resp.success) {
        /* final model = UserDataModel.fromJson(resp.response?.data?["data"]??{});*/

        /* CacheHelper.setUserToken(model.token);*/
        if (resp.response?.data["key"] == "fail") {
          emit(SignUpErrorState(resp.response?.data["msg"]));
        } else {
          // final model = UserDataModel.fromJson(resp.response?.data?["data"]??{});
          // CacheHelper.setUserToken(resp.response?.data?["data"]["token"]);
          emit(SignUpSuccessState(resp.msg));
        }

        // print("XOXOXOXOXOXOXXOXOXXOXOXOXXOXOXO ${CacheHelper.getUserToken()}");

      } else {
        emit(SignUpErrorState(resp.msg));
      }
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(SignUpErrorState(error.toString()));
    }
  }
}
