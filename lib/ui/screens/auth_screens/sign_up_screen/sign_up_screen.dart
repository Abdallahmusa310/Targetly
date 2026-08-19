import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:targetly/data/firebase/auth_service.dart';
import 'package:targetly/core/animations/homescreenanimation.dart';
import 'package:targetly/data/hive/hive_manager.dart';
import 'package:targetly/logic/Clients/cubit/client_cubit.dart';
import 'package:targetly/logic/activity/cubit/recentactivity_cubit.dart';
import 'package:targetly/logic/target/target_cubit/cubit/target_cubit.dart';
import 'package:targetly/logic/user/cubit/user_cubit.dart';
import 'package:targetly/ui/screens/auth_screens/sign_up_screen/widgets/sign_up_body.dart';
import 'package:targetly/ui/screens/auth_screens/sign_up_screen/widgets/sign_up_form.dart';
import 'package:targetly/ui/screens/auth_screens/sign_up_screen/widgets/sign_up_prompt.dart';
import 'package:targetly/ui/shared/boutton.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Staggeredwidget(
                        index: 0,
                        animate: true,
                        child: const SignUpBody(),
                      ),
                      const SizedBox(height: 16),
                      Staggeredwidget(
                        index: 1,
                        animate: true,
                        child: SignUpForm(
                          formKey: formKey,
                          emailcontroller: emailController,
                          passwordcontroller: passwordController,
                        ),
                      ),
                      const SizedBox(height: 30),

                      Staggeredwidget(
                        index: 2,
                        animate: true,
                        child: Sharedboutton(
                          text: 'Create account'.tr(),
                          isLoading: isLoading,
                          onTap: () async {
                            try {
                              if (formKey.currentState!.validate()) {
                                setState(() => isLoading = true);

                                final user = await authService.signUp(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                );

                                if (user != null) {
                                  final name = nameController.text.trim();
                                  await user.updateDisplayName(name);

                                  if (!context.mounted) return;
                                  await HiveManager.openUserBoxes();
                                  if (!context.mounted) return;

                                  context.read<UserCubit>().loadUser();
                                  context.read<TargetCubit>().fetchTarget();
                                  context.read<ClinetCubit>().fetchClients();
                                  context
                                      .read<ActivityCubit>()
                                      .fetchActivities();

                                  Navigator.pushReplacementNamed(
                                    context,
                                    '/navigation',
                                  );
                                } else {
                                  setState(() => isLoading = false);
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Sign up failed"),
                                      ),
                                    );
                                  }
                                }
                              }
                            } catch (e) {
                              if (!context.mounted) return;
                              setState(() => isLoading = false);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())),
                              );
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      Staggeredwidget(
                        index: 3,
                        animate: true,
                        child: const SignUpPrompt(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
