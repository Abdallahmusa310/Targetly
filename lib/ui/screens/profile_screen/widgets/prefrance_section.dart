import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:targetly/ui/screens/profile_screen/widgets/build_tile.dart';

class PrefranceSection extends StatelessWidget {
  const PrefranceSection({super.key});

  @override
  Widget build(BuildContext context) {
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
              builder: (_) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Choose Language".tr(),
                        style: const TextStyle(
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
                        onTap: () {
                          context.setLocale(const Locale('en'));
                          Navigator.pop(context);
                        },
                      ),

                      ListTile(
                        leading: const Text(
                          "🇪🇬",
                          style: TextStyle(fontSize: 24),
                        ),
                        title: const Text("العربية"),
                        onTap: () {
                          context.setLocale(const Locale('ar'));
                          Navigator.pop(context);
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
          subtitle: "Remove cached app data".tr(),
          iconColor: Colors.orange,
          onTap: () async {
            /// امسح البيانات المحلية هنا
          },
        ),
      ],
    );
  }
}
