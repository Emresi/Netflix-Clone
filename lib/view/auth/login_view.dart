import 'package:flutter/material.dart';
import 'package:netflix_clone/core/provider/auth_provider.dart';
import 'package:netflix_clone/product/constants/locale_keys.dart';
import 'package:netflix_clone/product/widgets/auth/auth_button.dart';
import 'package:netflix_clone/product/widgets/auth/auth_form_field.dart';
import 'package:netflix_clone/product/widgets/auth/helpers.dart';
import 'package:netflix_clone/product/widgets/sized_20.dart';
import 'package:netflix_clone/view/auth/register_view.dart';

import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(LocaleKeys.kAuthImageLink, fit: BoxFit.cover),
          Container(color: Colors.black.withOpacity(0.6)),
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 80),
            child: Consumer<AuthProvider>(
              builder: (context, authProvider, child) {
                buildMessageSnackbar(context, authProvider);

                return Form(
                  key: formKey,
                  child: authFormBuilder(
                    title: LocaleKeys.kSignIn,
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
                        label: LocaleKeys.kSignIn,
                        emailController: emailController,
                        passwordController: passwordController,
                        formKey: formKey,
                      ),
                      Center(
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            LocaleKeys.kForgot,
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                      const Sized20(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            LocaleKeys.kNoAccount,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute<RegisterView>(builder: (_) => const RegisterView()),
                              );
                            },
                            child: const Text(
                              LocaleKeys.kSignUp,
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
        ],
      ),
    );
  }
}
