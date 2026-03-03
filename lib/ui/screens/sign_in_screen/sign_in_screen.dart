import 'package:flutter/material.dart';
import 'package:targetly/ui/screens/sign_in_screen/widgets/waves.dart';
import 'package:targetly/ui/shared/boutton.dart';
import 'package:targetly/ui/shared/text_field.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                LightWave(),
                MidWave(),
                MainWave(),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: -130,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          'assets/targetly icon.png',
                          width: 180,
                          height: 180,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 100),

            /// ====== FORM SECTION ======
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const Text(
                    'Welcome Back!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff2B1E5E),
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Please sign in to continue',
                    style: TextStyle(fontSize: 16, color: Color(0xff8F92C2)),
                  ),

                  const SizedBox(height: 30),

                  SharedTextFeild(
                    hintText: "Email",
                    hintStyle: const TextStyle(color: Color(0xff8F92C2)),
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Color(0xff969ACA),
                    ),
                  ),

                  const SizedBox(height: 12),

                  SharedTextFeild(
                    hintText: "Password",
                    hintStyle: const TextStyle(color: Color(0xff8F92C2)),
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Color(0xff969ACA),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Sharedboutton(),

                  const SizedBox(height: 16),

                  const Text(
                    'Forget Password?',
                    style: TextStyle(
                      color: Color(0xff2B1E5E),
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Don\'t have an account? ',
                        style: TextStyle(color: Color(0xff8F92C2)),
                      ),
                      Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Color(0xff6A5AE0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
