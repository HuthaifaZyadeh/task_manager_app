import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_do/app/auth/presentation/bloc/auth_bloc.dart';
import 'package:simple_do/src/components/app_button.dart';
import 'package:simple_do/src/components/app_text.dart';
import 'package:simple_do/src/components/custom_text_field.dart';
import 'package:simple_do/src/utils/validator.dart';

import '../../../../src/routing/routes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: _listener,
              builder: _builder,
            ),
          ),
        ),
      ),
    );
  }

  void _listener(BuildContext context, AuthState state) {
    if (state.loginSuccess) {
      context.go(Routes.tasks);
    }
  }

  Widget _builder(BuildContext context, AuthState state) {
    final bloc = context.read<AuthBloc>();
    return Form(
      key: bloc.formKey,
      autovalidateMode: AutovalidateMode.onUnfocus,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppText(
            text: 'Hi there!',
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
          48.verticalSpace,
          CustomTextField(
            controller: bloc.usernameController,
            width: 300.w,
            label: 'Username',
            validator: Validator.nameValidator,
          ),
          12.verticalSpace,
          CustomTextField(
            controller: bloc.passwordController,
            label: 'Password',
            width: 300.w,
            isPassword: true,
            validator: Validator.passwordValidator,
          ),
          24.verticalSpace,
          AppButton(
            title: 'Login',
            isLoading: state.loading,
            onPressed: () {
              if (bloc.formKey.currentState!.validate()) {
                bloc.add(LoginEvent());
              }
            },
            width: 200,
            height: 50,
          ),
        ],
      ),
    );
  }
}
