import 'package:flutter/material.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            children: [
              Image.asset('assets/images/verifi.png'),
              SizedBox(height: 71),
              Center(
                child: Text(
                  "Almost There!",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF002147),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Text(
                "We’re reviewing your profile. Approval confirmation will be sent to your email.",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF737373),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 31),
              Center(
                child: RotationTransition(
                  turns: _controller,
                  child: Image.asset(
                    'assets/images/load_image.png',
                    width: 143,
                    height: 143,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
