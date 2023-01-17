import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:task_2/screens/auth/register/bloc/event.dart';
import 'package:task_2/screens/auth/register/bloc/state.dart';
import 'package:task_2/screens/auth/verify_account/view.dart';
import '../../../core/shared/helpers/helpers.dart';
import '../../../core/shared/helpers/image_picker.dart';
import '../../../core/shared/styles/colors.dart';
import '../../../core/shared/text/auth_header.dart';
import '../../../core/shared/widgets/app_bar.dart';
import '../../../core/shared/widgets/app_button.dart';
import '../../../core/shared/widgets/app_input.dart';
import '../../../gen/fonts.gen.dart';
import '../../../generated/locale_keys.g.dart';
import 'bloc/bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final signUpBloc = KiwiContainer().resolve<SignUpBloc>();
  File? file;
  SignUpPostEvent signUpPostEvent = SignUpPostEvent();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
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
        title: LocaleKeys.createAccount.tr(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 17.r),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 16.r),
                  child: Center(
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: () => AppAlert.init.imagePickerDialog(
                            context: context,
                            onSubmit: (v) {
                              setState(() {
                                signUpPostEvent.image = v;
                              });
                            },
                            withCrop: true,
                          ),
                          child: Container(
                            height: 72.h,
                            width: 72.w,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: primaryColor),
                                image: DecorationImage(
                                    image: signUpPostEvent.image == null
                                        ? const AssetImage(
                                                'assets/images/avatar.jpg')
                                            as ImageProvider
                                        : FileImage(signUpPostEvent.image!),
                                    fit: BoxFit.fill)),
                            // child: file==null?Icon(Icons.camera_alt):
                            // CircleAvatar(child: Image.file(file!),radius: 50.h,),
                          ),
                        ),
                        Positioned(
                            bottom: 1.h,
                            right: 5.w,
                            child: CircleAvatar(
                              radius: 12.w,
                              backgroundColor: primaryColor,
                              child: Icon(
                                Icons.camera_alt,
                                size: 22.sp,
                                color: Colors.white,
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.r),
                  child: Center(
                      child: Text(
                    signUpPostEvent.userName.text.isNotEmpty
                        ? signUpPostEvent.userName.text
                        : '',
                    style: TextStyle(
                        fontSize: 13.sp, fontFamily: FontFamily.medium),
                  )),
                ),
                AuthHeaders(title: LocaleKeys.name.tr(), top: 23.59.r),
                AppInput(
                  top: 11.34.r,
                  controller: signUpPostEvent.userName,
                    validate: (value) {
                    return value.isEmpty ? LocaleKeys.entreName.tr() : null;
                  },
                  hint: LocaleKeys.entreName.tr(),
                ),
                AuthHeaders(title: LocaleKeys.phoneNumber.tr(), top: 12.66.r),
                AppInput(
                  top: 11.34.r,
                  controller: signUpPostEvent.phoneController,
                     validate: (value) {
                    return value.isEmpty ? LocaleKeys.enterPhoneNumber.tr() : null;
                  },
                  hint: LocaleKeys.enterPhoneNumber.tr(),
                ),
                AuthHeaders(title: LocaleKeys.email.tr(), top: 12.66.r),
                AppInput(
                  top: 11.34.r,
                  controller: signUpPostEvent.email,
                  suffixIcon: Row(children: const [
                    VerticalDivider(),
                  ]),
                  hint: LocaleKeys.entreEmail.tr(),
                ),
                AuthHeaders(
                    title: LocaleKeys.educationalLevel.tr(), top: 14.03.r),
                AppInput(
                  top: 11.34.r,
                  validate: (String? value) {
                    return null;
                  },
                  hint: LocaleKeys.enterEducationalLevel.tr(),
                ),
                AuthHeaders(title: LocaleKeys.password.tr(), top: 12.96.r),
                AppInput(
                  controller: signUpPostEvent.passwordController,
                  top: 11.34.r,
                     validate: (value) {
                    return value.isEmpty ? LocaleKeys.enterPassword.tr() : null;
                  },
                  hint: LocaleKeys.enterPassword.tr(),
                ),
                AuthHeaders(
                    title: LocaleKeys.confirmPassword.tr(), top: 12.66.r),
                AppInput(
                  controller: signUpPostEvent.conifrmPassword,
                  top: 11.34.r,
                  hint: LocaleKeys.entrePasswordAgain.tr(),
                  validate: (value) {
                    if (value!.isEmpty) {
                      return LocaleKeys.entrePasswordAgain.tr();
                    }
                    return null;
                  },
                ),
                BlocConsumer(
                    bloc: signUpBloc,
                    builder: (context, state) {
                      if (state is SignUpLoadingState) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return AppButton(
                          top: 31.r,
                          bottom: 36.r,
                          onTap: () {
                            final FormState form = formKey.currentState!;

                            if (form.validate()) {
                              signUpBloc.add(signUpPostEvent);
                            }

                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => const VerifyAccountScreen()),
                            // );
                          },
                          title: LocaleKeys.newRegister.tr(),
                        );
                      }
                    },
                    listener: (context, state) {
                      if (state is SignUpSuccessState) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VerifyAccountScreen(
                                    signUpPostEvent: signUpPostEvent,
                                  )),
                        );
                      } else if (state is SignUpErrorState) {
                        showToast(text: state.msg, state: ToastStates.ERROR);
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
