import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile/components/common_loader.dart';
import 'package:mobile/pages/common/camera_page.dart';
import 'package:mobile/pages/common/signin_page.dart';

class LandingPage extends StatefulWidget {
  static const path = "landing_page";

  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  static final _fa = FirebaseAuth.instance;

  void _checkAuth() {
    final path = _fa.currentUser != null ? CameraPage.path : SignInPage.path;
    Navigator.of(context).pushNamedAndRemoveUntil(path, (route) => false);
  }

  @override
  void initState() {
    Timer(const Duration(seconds: 3), _checkAuth);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CommonLoader(),
    );
  }
}
