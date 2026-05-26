import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:targetly/core/animations/homescreenanimation.dart';
import 'package:targetly/core/routing/routs.dart';
import 'package:targetly/data/hive/hive_manager.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  Locale? _selectedLocale;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _selectedLocale ??= context.locale;
  }

  // Staggeredwidget(
  //                   index: 0,
  //                   animate: hasanimated,
  //                   child: Buildheader(),
  //                 ),

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                Staggeredwidget(
                  index: 0,
                  animate: true,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/targetlyicon.png',
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                Staggeredwidget(
                  index: 1,
                  animate: true,
                  child: ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [
                        Color(0xFF7F73E6),
                        Color.fromARGB(255, 13, 157, 201),
                      ],
                    ).createShader(bounds),
                    child: Text(
                      'Targetly',
                      style: GoogleFonts.poppins(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                Staggeredwidget(
                  index: 2,
                  animate: true,
                  child: SizedBox(
                    height: 50,
                    child: AnimatedTextKit(
                      repeatForever: true,
                      key: ValueKey(_selectedLocale),
                      animatedTexts: [
                        TypewriterAnimatedText(
                          _selectedLocale == const Locale('ar')
                              ? 'تتبع أهدافك بثقة'
                              : 'Track your goals with confidence',
                          textStyle: const TextStyle(
                            fontSize: 15,
                            color: Color(0xff8F92C2),
                          ),
                          speed: const Duration(milliseconds: 60),
                        ),
                        TypewriterAnimatedText(
                          _selectedLocale == const Locale('ar')
                              ? 'أدر. تتبع. أنجز.'
                              : 'Manage. Track. Achieve.',
                          textStyle: const TextStyle(
                            fontSize: 15,
                            color: Color(0xff8F92C2),
                          ),
                          speed: const Duration(milliseconds: 60),
                        ),
                        TypewriterAnimatedText(
                          _selectedLocale == const Locale('ar')
                              ? 'رفيقك الذكي في المبيعات'
                              : 'Your smart sales companion',
                          textStyle: const TextStyle(
                            fontSize: 15,
                            color: Color(0xff8F92C2),
                          ),
                          speed: const Duration(milliseconds: 60),
                        ),
                      ],
                    ),
                  ),
                ),

                const Spacer(),

                // Language Selection
                Staggeredwidget(
                  index: 3,
                  animate: true,
                  child: Text(
                    'Choose your language'.tr(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                Staggeredwidget(
                  index: 4,
                  animate: true,
                  child: Row(
                    children: [
                      Expanded(
                        child: _LanguageCard(
                          flag: '🇺🇸',
                          language: 'English',
                          isSelected: _selectedLocale == const Locale('en'),
                          onTap: () async {
                            await context.setLocale(const Locale('en'));
                            if (mounted) {
                              setState(
                                () => _selectedLocale = const Locale('en'),
                              );
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _LanguageCard(
                          flag: '🇪🇬',
                          language: 'العربية',
                          isSelected: _selectedLocale == const Locale('ar'),
                          onTap: () async {
                            await context.setLocale(const Locale('ar'));
                            if (mounted) {
                              setState(
                                () => _selectedLocale = const Locale('ar'),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                Staggeredwidget(
                  index: 5,
                  animate: true,
                  child: Text(
                    _selectedLocale == const Locale('ar')
                        ? 'هل تمتلك حساب؟'
                        : 'Do you have an account?',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                Staggeredwidget(
                  index: 6,
                  animate: true,
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _selectedLocale == null
                              ? null
                              : () {
                                  HiveManager.setNotFirstTime();
                                  Navigator.pushReplacementNamed(
                                    context,
                                    AppRoutes.signInScreen,
                                  );
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF7F73E6),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(
                            _selectedLocale == const Locale('ar')
                                ? 'نعم، سجل دخول'
                                : 'Yes, Sign In',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _selectedLocale == null
                              ? null
                              : () {
                                  HiveManager.setNotFirstTime();
                                  Navigator.pushReplacementNamed(
                                    context,
                                    AppRoutes.signUpScreen,
                                  );
                                },
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            side: const BorderSide(color: Color(0xFF7F73E6)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(
                            _selectedLocale == const Locale('ar')
                                ? 'لا، إنشاء حساب'
                                : 'No, Sign Up',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF7F73E6),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LanguageCard extends StatelessWidget {
  const _LanguageCard({
    required this.flag,
    required this.language,
    required this.isSelected,
    required this.onTap,
  });

  final String flag;
  final String language;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF7F73E6).withOpacity(0.1)
              : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFF7F73E6) : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Text(flag, style: const TextStyle(fontSize: 32)),
            const SizedBox(height: 8),
            Text(
              language,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isSelected ? const Color(0xFF7F73E6) : Colors.grey,
              ),
            ),
            if (isSelected) ...[
              const SizedBox(height: 4),
              const Icon(
                Icons.check_circle,
                color: Color(0xFF7F73E6),
                size: 18,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
