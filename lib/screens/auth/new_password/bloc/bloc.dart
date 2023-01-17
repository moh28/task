import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../core/shared/helpers/cache_helper.dart';
import '../../../../core/shared/network/server_gate.dart';
import '../../../../models/user_data.dart';
import 'event.dart';
import 'state.dart';

class ResedPasswordBloc extends Bloc<ResedPasswordEvents, ResedPasswordStates> {
  ServerGate serverGate = ServerGate();
  // final formKey = GlobalKey<FormState>();
  // final passwordController = TextEditingController();
  // final phoneController = TextEditingController();

  ResedPasswordBloc() : super((ResedPasswordInitialState())) {
    on<ResedPasswordPostEvent>(_postResedPassword);
  }

  Future<void> _postResedPassword(
      ResedPasswordPostEvent event, Emitter<ResedPasswordStates> emit) async {
    emit(ResedPasswordLoadingState());
    try {
      final resp = await serverGate.sendToServer(
          url: 'reset-password', body: event.body);
      print(event.body.toString());
      if (resp.success) {
        /* final model = UserDataModel.fromJson(resp.response?.data?["data"]??{});*/
        print(resp.response?.data);
        /* CacheHelper.setUserToken(model.token);*/
        if (resp.response?.data["key"] == "fail") {
          emit(ResedPasswordErrorState(resp.response?.data["msg"]));
        } else {
          // final model = UserDataModel.fromJson(resp.response?.data?["data"]??{});
          emit(ResedPasswordSuccessState(resp.msg));
        }

        // print("XOXOXOXOXOXOXXOXOXXOXOXOXXOXOXO ${CacheHelper.getUserToken()}");

      } else {
        emit(ResedPasswordErrorState(resp.msg));
      }
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ResedPasswordErrorState(error.toString()));
    }
  }
}
