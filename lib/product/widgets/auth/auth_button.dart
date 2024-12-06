import 'package:flutter/material.dart';
import 'package:netflix_clone/core/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    required this.label,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
    this.isLogin = true,
    super.key,
  });

  final String label;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;
  final bool isLogin;

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        ),
        onPressed: authProvider.isLoading
            ? null
            : () async {
                if (formKey.currentState!.validate()) {
                  final email = emailController.text.trim();
                  final password = passwordController.text.trim();
                  if (isLogin) {
                    await context.read<AuthProvider>().login(email, password);
                  } else {
                    await context.read<AuthProvider>().register(email, password);
                  }
                  emailController.clear();
                  passwordController.clear();
                }
              },
        child: authProvider.isLoading
            ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            : Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}
