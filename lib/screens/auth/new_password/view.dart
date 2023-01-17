// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';

import 'package:task_2/screens/auth/login/view.dart';

import '../../../core/shared/helpers/helpers.dart';
import '../../../core/shared/text/auth_dialog.dart';
import '../../../core/shared/text/auth_header.dart';
import '../../../core/shared/widgets/app_bar.dart';
import '../../../core/shared/widgets/app_button.dart';
import '../../../core/shared/widgets/app_input.dart';
import '../../../core/shared/widgets/app_logo.dart';
import '../../../generated/locale_keys.g.dart';
import 'bloc/bloc.dart';
import 'bloc/event.dart';
import 'bloc/state.dart';

class NewPasswordScreen extends StatefulWidget {
  final String phone;
  const NewPasswordScreen({
    Key? key,
    required this.phone,
  }) : super(key: key);

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final event = ResedPasswordPostEvent();
  final bloc = KiwiContainer().resolve<ResedPasswordBloc>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.newPassword.tr(),
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
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: AppLogo(
                top: 33.59.r,
              )),
              AuthDialog(
                title:
                    'هذا النص هو مثال لنص يمكن أن يستبدل فى نفس المساحه,لقد تم توليد هذا النص من',
                top: 24.17.r,
                start: 55.r,
                end: 55.r,
                bottom: 35.66.r,
              ),
              AuthHeaders(
                start: 17.r,
                end: 17.r,
                title: LocaleKeys.code.tr(),
              ),
              AppInput(
                top: 11.34.r,
                start: 17.r,
                controller: event.code,
                validate: (value) {
                  //Return a error string
                  return value.isEmpty ? 'قم بإدخال كود التفعيل ' : null;
                },
                end: 17.r,
                suffixIcon: Row(
                  children: const [
                    VerticalDivider(),
                  ],
                ),
                hint: LocaleKeys.pleaseEnterCode.tr(),
              ),
              AuthHeaders(
                top: 13.6.r,
                start: 17.r,
                end: 17.r,
                title: LocaleKeys.newPassword.tr(),
              ),
              AppInput(
                top: 11.34.r,
                start: 17.r,
                end: 17.r,
                validate: (value) {
                  //Return a error string
                  return value.isEmpty ? 'قم بإدخال كلمة المرور ' : null;
                },
                controller: event.password,
                suffixIcon: Row(
                  children: const [
                    VerticalDivider(),
                  ],
                ),
                hint: LocaleKeys.pleaseEnterNewPassword.tr(),
              ),
              AuthHeaders(
                top: 13.6.r,
                start: 17.r,
                end: 17.r,
                title: LocaleKeys.confirmNewPassword.tr(),
              ),
              AppInput(
                top: 11.34.r,
                start: 17.r,
                controller: event.confirm,
                validate: (value) {
                  //Return a error string
                  return value.isEmpty ? 'قم بتأكيد كلمة المرور ' : null;
                },
                end: 17.r,
                suffixIcon: Row(
                  children: const [
                    VerticalDivider(),
                  ],
                ),
                hint: LocaleKeys.pleaseConfirmNewPassword.tr(),
              ),
              BlocConsumer(
                  bloc: bloc,
                  builder: (context, state) {
                    if (state is ResedPasswordLoadingState) {
                      return const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    } else {
                      return AppButton(
                        title: LocaleKeys.access.tr(),
                        onTap: () {
                          event.phoneController.text = widget.phone;
                          if (formKey.currentState!.validate()) {
                            bloc.add(event);
                          }
                        },
                        top: 39.6.r,
                        start: 31.r,
                        end: 31.r,
                      );
                    }
                  },
                  listener: (context, state) {
                    if (state is ResedPasswordSuccessState) {
                      showToast(text: state.msg, state: ToastStates.SUCCESS);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LogInScreen()));
                    } else if (state is ResedPasswordErrorState) {
                      showToast(text: state.msg, state: ToastStates.ERROR);
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
