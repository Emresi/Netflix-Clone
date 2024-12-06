import 'package:flutter/material.dart';
import 'package:netflix_clone/core/provider/auth_provider.dart';
import 'package:netflix_clone/product/constants/locale_keys.dart';
import 'package:netflix_clone/product/widgets/auth/auth_button.dart';
import 'package:netflix_clone/product/widgets/auth/auth_form_field.dart';
import 'package:netflix_clone/product/widgets/auth/helpers.dart';
import 'package:netflix_clone/product/widgets/sized_20.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 80),
        child: Consumer<AuthProvider>(
          builder: (context, authProvider, child) {
            buildMessageSnackbar(context, authProvider);
            return Form(
              key: formKey,
              child: authFormBuilder(
                title: LocaleKeys.kSignUp,
                fields: [
                  AuthFormField(
                    controller: emailController,
                    hintText: LocaleKeys.kEmail,
                    isEmail: true,
                  ),
                  const Sized20(),
                  AuthFormField(
                    controller: passwordController,
                    hintText: LocaleKeys.kPwd,
                  ),
                ],
                actions: [
                  AuthButton(
                    label: LocaleKeys.kSignUp,
                    emailController: emailController,
                    passwordController: passwordController,
                    formKey: formKey,
                    isLogin: false,
                  ),
                  Center(
                    child: TextButton(
                      onPressed: context.read<AuthProvider>().resendVerificationEmail,
                      child: const Text(
                        LocaleKeys.kReVerify,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                  const Sized20(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        LocaleKeys.kHaveAccount,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          LocaleKeys.kSignIn,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
