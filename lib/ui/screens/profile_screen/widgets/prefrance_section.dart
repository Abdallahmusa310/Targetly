import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:targetly/core/routing/routs.dart';
import 'package:targetly/ui/screens/profile_screen/widgets/build_tile.dart';

class PrefranceSection extends StatelessWidget {
  const PrefranceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLocale = context.locale;

    return Column(
      children: [
        BuildTile(
          icon: Icons.dark_mode,
          title: "Dark Mode".tr(),
          subtitle: "Coming soon".tr(),
          onTap: () {},
        ),
        BuildTile(
          icon: Icons.language,
          title: "Language".tr(),
          subtitle: "Change app language".tr(),
          onTap: () {
            showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              builder: (sheetContext) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Choose Language".tr(),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ListTile(
                        leading: const Text(
                          "🇺🇸",
                          style: TextStyle(fontSize: 24),
                        ),
                        title: const Text("English"),
                        trailing: currentLocale == const Locale('en')
                            ? const Icon(Icons.check, color: Color(0xFF7F73E6))
                            : null,
                        onTap: () async {
                          await context.setLocale(const Locale('en'));
                          if (context.mounted) {
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              AppRoutes.navigationScreen,
                              (route) => false,
                            );
                          }
                        },
                      ),
                      ListTile(
                        leading: const Text(
                          "🇪🇬",
                          style: TextStyle(fontSize: 24),
                        ),
                        title: const Text("العربية"),
                        trailing: currentLocale == const Locale('ar')
                            ? const Icon(Icons.check, color: Color(0xFF7F73E6))
                            : null,
                        onTap: () async {
                          await context.setLocale(const Locale('ar'));
                          if (context.mounted) {
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              AppRoutes.navigationScreen,
                              (route) => false,
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                );
              },
            );
          },
        ),
        BuildTile(
          icon: Icons.delete_forever,
          title: "Clear Data".tr(),
          subtitle: "Coming soon".tr(),
          iconColor: Colors.orange,
          onTap: () async {},
        ),
      ],
    );
  }
}
