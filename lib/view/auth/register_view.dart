import 'package:flutter/material.dart';
import 'package:netflix_clone/core/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 80),
            Text(
              'Sign Up',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: 40),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(hintText: 'Email'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(hintText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 40),
            if (authProvider.isLoading)
              const Center(child: CircularProgressIndicator())
            else
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      authProvider.register(
                        _emailController.text.trim(),
                        _passwordController.text.trim(),
                      );
                    },
                    child: const Center(child: Text('Sign Up')),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: authProvider.resendVerificationEmail,
                    child: const Text('Resend Verification Email', style: TextStyle(color: Colors.redAccent)),
                  ),
                ],
              ),
            const SizedBox(height: 20),
            if (authProvider.message != null)
              Center(
                child: Text(
                  authProvider.message!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.redAccent),
                ),
              ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                'Already have an account?',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Sign In', style: TextStyle(color: Colors.redAccent)),
            ),
          ],
        ),
      ),
    );
  }
}
