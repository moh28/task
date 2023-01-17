import 'package:custom_timer/custom_timer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:kiwi/kiwi.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_2/core/shared/styles/colors.dart';
import 'package:task_2/core/shared/text/auth_dialog.dart';
import 'package:task_2/core/shared/widgets/app_bar.dart';
import 'package:task_2/core/shared/widgets/app_button.dart';
import 'package:task_2/core/shared/widgets/app_logo.dart';
import 'package:task_2/gen/fonts.gen.dart';
import 'package:task_2/screens/nav/view.dart';

import '../../../core/shared/helpers/helpers.dart';
import '../../../generated/locale_keys.g.dart';
import '../register/bloc/event.dart';
import '../register/bloc/state.dart';
import 'bloc/bloc.dart';
import 'bloc/event.dart';
import 'bloc/state.dart';

class VerifyAccountScreen extends StatefulWidget {
  final SignUpPostEvent signUpPostEvent;

  const VerifyAccountScreen({Key? key, required this.signUpPostEvent})
      : super(key: key);

  @override
  State<VerifyAccountScreen> createState() => _VerifyAccountScreenState();
}

class _VerifyAccountScreenState extends State<VerifyAccountScreen>
    with SingleTickerProviderStateMixin {
  late final CustomTimerController _controller;
  final otpController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final verfiy = VerifyPostEvent();
  final bloc = KiwiContainer().resolve<VerifyBloc>();
  final resend = KiwiContainer().resolve<ResendBloc>();
  final resedEvent = ResendPostEvent();
  String? time;
  @override
  void initState() {
    _controller = CustomTimerController(
        begin: const Duration(seconds: 60),
        end: Duration.zero,
        initialState: CustomTimerState.reset,
        interval: CustomTimerInterval.milliseconds,
        vsync: this)
      ..start();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.activeAccount.tr(),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 24.sp,
          ),
        ),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Center(
                child: AppLogo(
              top: 34.r,
            )),
            AuthDialog(
              title:
                  'هذا النص هو مثال لنص يمكن أن يستبدل فى نفس المساحه,لقد تم توليد هذا النص من',
              top: 23.76.r,
              start: 55.r,
              end: 55.r,
              bottom: 36.66.r,
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(
                  start: 33.r, end: 33.r, bottom: 25.34.r),
              child: PinCodeTextField(
                /*validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'faild';
                    }
                    return null;
                  },*/
                validator: (value) {
                  return value!.isEmpty ? LocaleKeys.code.tr() : null;
                },
                controller: verfiy.code,
                length: 4,
                keyboardType: TextInputType.number,
                autoFocus: true,
                autoDisposeControllers: true,
                obscureText: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(10.w),
                  fieldHeight: 48.h,
                  fieldWidth: 67.w,
                  activeFillColor: HexColor('#FFFFFF'),
                  selectedColor: primaryColor,
                  selectedFillColor: HexColor('#F5F5F5'),
                  inactiveColor: HexColor('#F3F3F3'),
                  inactiveFillColor: HexColor('#F5F5F5'),
                ),
                animationDuration: const Duration(milliseconds: 300),
                enableActiveFill: true,
                onCompleted: (v) {
                  if (kDebugMode) {
                    print("Completed");
                  }
                },
                onChanged: (value) {
                  if (kDebugMode) {
                    print(value);
                  }
                  setState(() {});
                },
                beforeTextPaste: (text) {
                  if (kDebugMode) {
                    print("Allowing to paste $text");
                  }

                  return true;
                },
                appContext: context,
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(start: 33.78.r, end: 36.66.r),
              child: SizedBox(
                height: 16.h,
                child: Row(
                  children: [
                    Text(
                      LocaleKeys.noCode.tr(),
                      style: TextStyle(
                          fontFamily: FontFamily.arabic,
                          fontSize: 12.h,
                          color: const Color(0xff9A9A9A)),
                    ),
                    _controller.interval != CustomTimerInterval.milliseconds
                        ? const SizedBox.shrink()
                        : BlocConsumer(
                            bloc: resend,
                            builder: (context, state) {
                              if (state is ResendLoadingState) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else {
                                return InkWell(
                                  onTap: () {
                                    resedEvent.phoneController =
                                        widget.signUpPostEvent.phoneController;
                                    resend.add(resedEvent);
                                  },
                                  child: Text(
                                    LocaleKeys.resendCode.tr(),
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontFamily: FontFamily.medium,
                                        color: primaryColor),
                                  ),
                                );
                              }
                            },
                            listener: (context, state) {
                              if (state is ResendSuccessState) {
                                setState(() {
                                  _controller.start();
                                });
                                showToast(
                                    text: state.msg,
                                    state: ToastStates.SUCCESS);
                              } else if (state is VerifyErrorState) {
                                showToast(
                                    text: state.msg, state: ToastStates.ERROR);
                              }
                            }),
                    const Spacer(),
                    Text(
                      LocaleKeys.timeRemaining.tr(),
                      style: TextStyle(
                          fontFamily: FontFamily.arabic,
                          fontSize: 12.h,
                          color: const Color(0xff9A9A9A)),
                    ),
                    SizedBox(
                      width: 7.w,
                    ),
                    CustomTimer(
                        controller: _controller,
                        builder: (state, remaining) {
                          time = "${remaining.minutes}:${remaining.seconds}";

                          // Build the widget you want!
                          return SizedBox(
                              width: 32.w,
                              child: Text(
                                  "${remaining.minutes}:${remaining.seconds}",
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      fontFamily: FontFamily.medium,
                                      color: primaryColor)));
                        }),
                  ],
                ),
              ),
            ),
            BlocConsumer(
                bloc: bloc,
                builder: (context, state) {
                  if (state is VerifyLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return AppButton(
                      top: 45.r,
                      start: 31.r,
                      end: 31.r,
                      onTap: () {
                        verfiy.phoneController =
                            widget.signUpPostEvent.phoneController;
                        verfiy.countryCode = widget.signUpPostEvent.countryCode;

                        if (formKey.currentState!.validate()) {
                          //   print("sadsadsa");
                          bloc.add(verfiy);
                        }
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => const VerifyAccountScreen()),
                        // );
                      },
                      title: LocaleKeys.access.tr(),
                    );
                  }
                },
                listener: (context, state) {
                  if (state is VerifySuccessState) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()));
                  } else if (state is VerifyErrorState) {
                    showToast(text: state.msg, state: ToastStates.ERROR);
                  }
                }),
            // AppButton(
            //   title: LocaleKeys.access.tr(),
            //   onTap: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => const HomeScreen()));
            //   },
            //   top: 45.r,
            //   start: 31.r,
            //   end: 31.r,
            // )
          ],
        ),
      ),
    );
  }
}
