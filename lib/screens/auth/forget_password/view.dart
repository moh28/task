import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:task_2/screens/auth/new_password/view.dart';

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

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final bloc = KiwiContainer().resolve<ForgetPasswordInBloc>();
  final event = ForgetPasswordPostEvent();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.forgetThisPassword.tr(),
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
              start: 31.r,
              title: LocaleKeys.phoneNumber.tr(),
            ),
            AppInput(
              top: 11.34.r,
              controller: event.phoneController,
              start: 31.r,
              validate: (value) {
                return value.isEmpty ? LocaleKeys.enterPhoneNumber.tr() : null;
              },
              end: 31.r,
              suffixIcon: Row(
                children: const [
                  VerticalDivider(),
                ],
              ),
              hint: LocaleKeys.enterPhoneNumber.tr(),
            ),
            BlocConsumer(
                bloc: bloc,
                builder: (context, state) {
                  if (state is ForgetPasswordLoadingState) {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else {
                    return AppButton(
                      title: LocaleKeys.send.tr(),
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          bloc.add(event);
                        }
                      },
                      top: 36.r,
                      start: 31.r,
                      end: 31.r,
                    );
                  }
                },
                listener: (context, state) {
                  if (state is ForgetPasswordSuccessState) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewPasswordScreen(
                                  phone: event.phoneController.text,
                                )));
                  } else if (state is ForgetPasswordErrorState) {
                    showToast(text: state.msg, state: ToastStates.ERROR);
                  }
                })
          ],
        ),
      ),
    );
  }
}
