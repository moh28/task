import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../core/shared/helpers/cache_helper.dart';
import '../../../../core/shared/network/server_gate.dart';
import 'event.dart';
import 'state.dart';

class VerifyBloc extends Bloc<VerifyEvents, VerifyStates> {
  ServerGate serverGate = ServerGate();
  final formKey = GlobalKey<FormState>();

  VerifyBloc() : super((VerifyInitialState())) {
    on<VerifyPostEvent>(_postVerify);
  }

  Future<void> _postVerify(
      VerifyPostEvent event, Emitter<VerifyStates> emit) async {
    emit(VerifyLoadingState());
    try {
      final resp = await serverGate.sendToServer(
        url: 'activate?_method=patch',
        body: event.body,
      );
      print(event.body.toString()+"_____fffffffffff________");
      if (resp.success) {
        /* final model = UserDataModel.fromJson(resp.response?.data?["data"]??{});*/

        /* CacheHelper.setUserToken(model.token);*/
        if (resp.response?.data["key"] == "fail") {
          emit(VerifyErrorState(resp.response?.data["msg"]));
        } else {
          // final model = UserDataModel.fromJson(resp.response?.data?["data"]??{});
          CacheHelper.setUserToken(resp.response?.data?["data"]["token"]);
          emit(VerifySuccessState(resp.msg));
        }

        // print("XOXOXOXOXOXOXXOXOXXOXOXOXXOXOXO ${CacheHelper.getUserToken()}");

      } else {
        emit(VerifyErrorState(resp.msg));
      }
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(VerifyErrorState(error.toString()));
    }
  }
}


class ResendBloc extends Bloc<ResendEvents, ResendStates> {
  ServerGate serverGate = ServerGate();
  final formKey = GlobalKey<FormState>();

  ResendBloc() : super((ResendInitialState())) {
    on<ResendPostEvent>(_postVerify);
  }

  Future<void> _postVerify(
      ResendPostEvent event, Emitter<ResendStates> emit) async {
    emit(ResendLoadingState());
    try {
      final resp = await serverGate.getFromServer(
        url: 'resend-code?country_code=966&phone=${event.phoneController.text}',
      );
      if (resp.success) {
        /* final model = UserDataModel.fromJson(resp.response?.data?["data"]??{});*/

        /* CacheHelper.setUserToken(model.token);*/
        if (resp.response?.data["key"] == "fail") {
          emit(ResendErrorState(resp.response?.data["msg"]));
        } else {
          // final model = UserDataModel.fromJson(resp.response?.data?["data"]??{});
          // CacheHelper.setUserToken(resp.response?.data?["data"]["token"]);
          emit(ResendSuccessState(resp.msg));
        }

        // print("XOXOXOXOXOXOXXOXOXXOXOXOXXOXOXO ${CacheHelper.getUserToken()}");

      } else {
        emit(ResendErrorState(resp.msg));
      }
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ResendErrorState(error.toString()));
    }
  }
}