import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:task_2/core/shared/styles/colors.dart';
import 'package:task_2/core/shared/widgets/app_bar.dart';
import 'package:task_2/core/shared/widgets/app_button.dart';
import 'package:task_2/core/shared/widgets/app_input.dart';
import 'package:task_2/core/shared/widgets/app_logo.dart';
import 'package:task_2/gen/fonts.gen.dart';
import 'package:task_2/screens/auth/forget_password/view.dart';
import 'package:task_2/screens/auth/login/bloc/bloc.dart';
import 'package:task_2/screens/auth/login/bloc/state.dart';
import 'package:task_2/screens/auth/register/view.dart';
import 'package:task_2/screens/nav/view.dart';
import '../../../core/shared/helpers/helpers.dart';
import '../../../core/shared/text/auth_header.dart';
import '../../../generated/locale_keys.g.dart';
import 'bloc/event.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final bloc = KiwiContainer().resolve<LogInBloc>();
  final event = LogInPostEvent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.logIn.tr(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 31.r),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: AppLogo(
                  top: 36.r,
                )),
                AuthHeaders(
                  top: 52.r,
                  title: LocaleKeys.phoneNumber.tr(),
                ),
                AppInput(
                  controller: event.phoneController,
                  top: 11.34.r,
                  validate: (value) {
                    //Return a error string
                    return value.isEmpty ? 'قم بإدخال رقم الجوال' : null;
                  },
                  hint: LocaleKeys.enterPhoneNumber.tr(),
                ),
                SizedBox(height: 19.0.h),
                AuthHeaders(
                  title: LocaleKeys.password.tr(),
                  top: 19.r,
                ),
                AppInput(
                  controller: event.passwordController,
                  top: 11.34.r,
                  validate: (value) {
                    return value.isEmpty ? 'قم بإدخال كلمة المرور ' : null;
                  },
                  hint: LocaleKeys.enterPassword.tr(),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ForgetPasswordScreen()));
                      },
                      child: Text(
                        LocaleKeys.forgetThisPassword.tr(),
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 12.sp,
                          fontFamily: FontFamily.arabic,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                BlocConsumer(
                  bloc: bloc,
                  builder: (context, state) {
                    return AppButton(
                      top: 31.0.r,
                      bottom: 31.r,
                      onTap: () {
                        final FormState form = formKey.currentState!;

                        if (form.validate()) {
                          bloc.add(event);
                        }
                      },
                      title: LocaleKeys.logIn.tr(),
                    );
                  },
                  listener: (context, state) {
                    if (state is LogInSuccessState) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()),
                      );
                    } else if (state is LogInErrorState) {
                      showToast(text: state.msg, state: ToastStates.ERROR);
                    }
                  },
                ),
                Center(
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      LocaleKeys.visitor.tr(),
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 15.sp,
                        fontFamily: FontFamily.medium,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 50.r, top: 90.r),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        LocaleKeys.haveNotAccount.tr(),
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontFamily: FontFamily.medium,
                          color: primaryColor,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const RegisterScreen()));
                        },
                        child: Text(
                          LocaleKeys.creatingAccount.tr(),
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 15.sp,
                            fontFamily: FontFamily.medium,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
