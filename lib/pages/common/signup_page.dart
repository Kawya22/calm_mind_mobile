import 'package:flutter/material.dart';
import 'package:mobile/dto/out/create_user_dto.dart';
import 'package:mobile/pages/common/camera_page.dart';
import 'package:mobile/pages/common/signin_page.dart';
import 'package:mobile/services/auth_service.dart';

class SignUpPage extends StatefulWidget {
  static const path = "signup";

  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  static final _authService = AuthService.instance;

  final _nameController = TextEditingController(),
      _emailController = TextEditingController(),
      _passwordController = TextEditingController(),
      _confirmPasswordController = TextEditingController();

  CreateUserDto _buildModel() => CreateUserDto(
        email: _emailController.text,
        name: _nameController.text,
      );

  void _onSignUp(BuildContext context) async {
    try {
      final model = _buildModel();
      await _authService.signUp(model, _passwordController.text);

      if (!mounted) return;
      Navigator.of(context)
          .pushNamedAndRemoveUntil(CameraPage.path, (route) => false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Account created successful")),
      );
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error Occurred. Try again!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Background Image
          Image.asset(
            'assets/common/f.jpg', // Replace with your image path
            fit: BoxFit.values[2],
            width: double.infinity,
            height: double.infinity,
          ),

          Center(
            child: Column(
              children: [
                const Positioned(
                  top: 00,
                  right: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        " ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Card(
                  color: const Color(0xffffffff).withOpacity(0.8),
                  margin: const EdgeInsets.all(20),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Text("Sign Up",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 21,
                            )),
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
                              labelText: "Name",
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.person),
                            ),
                            controller: _nameController,
                          ),
                        ),
                        const SizedBox(height: 10),
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
                        const SizedBox(height: 10),
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
                        const SizedBox(height: 10),
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
                              labelText: "Confirm Password",
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.lock),
                            ),
                            obscureText: true,
                            controller: _confirmPasswordController,
                          ),
                        ),

                        const SizedBox(height: 25), // Add some spacing
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
                          onPressed: () => _onSignUp(context),
                          child: const Text("Sign Up"),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment
                              .center, //Center Row contents horizontally,
                          children: [
                            const Text("Already have an account?"),
                            TextButton(
                              onPressed: () => Navigator.of(context)
                                  .pushNamed(SignInPage.path),
                              child: const Text(
                                "Sign In",
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
