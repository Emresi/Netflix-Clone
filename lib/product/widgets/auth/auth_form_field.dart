import 'package:flutter/material.dart';
import 'package:netflix_clone/core/provider/auth_provider.dart';
import 'package:netflix_clone/product/constants/repo.dart';
import 'package:provider/provider.dart';

class AuthFormField extends StatelessWidget {
  const AuthFormField({
    required this.controller,
    required this.hintText,
    this.isEmail = false,
    super.key,
  });

  final TextEditingController controller;
  final String hintText;
  final bool isEmail;

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return TextFormField(
      controller: controller,
      obscureText: !isEmail && authProvider.obscurePwd,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        suffixIcon: isEmail
            ? null
            : IconButton(
                icon: Icon(
                  authProvider.obscurePwd ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: context.read<AuthProvider>().togglePasswordVisibility,
              ),
      ),
      validator: isEmail ? CustomValidators.emailValidator : CustomValidators.pwdValidator,
    );
  }
}
