import 'package:flutter/material.dart';
import 'package:mobile/pages/common/camera_page.dart';
import 'package:mobile/pages/common/signup_page.dart';
import 'package:mobile/services/auth_service.dart';

class SignInPage extends StatefulWidget {
  static const path = "signin";

  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  static final _authService = AuthService.instance;

  final _emailController = TextEditingController(),
      _passwordController = TextEditingController();

  Future<void> _onSignIn() async {
    try {
      await _authService.signIn(
        _emailController.text,
        _passwordController.text,
      );

      if (!mounted) return;
      Navigator.of(context)
          .pushNamedAndRemoveUntil(CameraPage.path, (route) => false);
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error Occurred. Check Your Credentials")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Image.asset(
            'assets/common/p.jpg',
            fit: BoxFit.values[2],
            width: double.infinity,
            height: double.infinity,
          ),
          const Positioned(
            top: 120,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome back,",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Sign in to continue",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),
                Card(
                  color: const Color(0xffffffff).withOpacity(0.8),
                  margin: const EdgeInsets.all(20),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Text("Sign In",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            )),
                        const SizedBox(height: 50),
                        // Add some spacing
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(
                              width: 1.0,
                              color: Colors.grey,
                            ),
                          ),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: "Email",
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.email),
                            ),
                            controller: _emailController,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(
                              width: 1.0,
                              color: Colors.grey,
                            ),
                          ),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: "Password",
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.lock),
                            ),
                            obscureText: true,
                            controller: _passwordController,
                          ),
                        ),
                        const SizedBox(height: 35),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 140.0,
                              vertical: 20.0,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                          onPressed: _onSignIn,
                          child: const Text("Sign In"),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account?"),
                            TextButton(
                              onPressed: () => Navigator.of(context)
                                  .pushNamed(SignUpPage.path),
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
