// PrefranceSection
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:targetly/core/routing/routs.dart';
import 'package:targetly/logic/thems/cubit/thems_cubit.dart';
import 'package:targetly/ui/screens/profile_screen/widgets/build_tile.dart';
import 'package:targetly/ui/screens/profile_screen/widgets/clear_dialog.dart';
import 'package:targetly/ui/screens/profile_screen/widgets/reset_dialog.dart';

class PrefranceSection extends StatelessWidget {
  const PrefranceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final currentLocale = context.locale;

    return Column(
      children: [
        BuildTile(
          icon: Icons.dark_mode,
          title: "Dark Mode".tr(),
          subtitle: "Switch theme".tr(),
          onTap: () => context.read<ThemsCubit>().toggleTheme(),
          trailing: Switch(
            value: context.watch<ThemsCubit>().currentTheme == ThemeMode.dark,
            onChanged: (_) => context.read<ThemsCubit>().toggleTheme(),
            activeColor: const Color(0xFF7F73E6),
          ),
        ),
        BuildTile(
          icon: Icons.language,
          title: "Language".tr(),
          subtitle: "Change app language".tr(),
          onTap: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: isDark ? const Color(0xFF1A1A2E) : Colors.white,
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
                          color: isDark
                              ? Colors.white
                              : const Color(0xff2B1E5E),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ListTile(
                        leading: const Text(
                          "🇺🇸",
                          style: TextStyle(fontSize: 24),
                        ),
                        title: Text(
                          "English",
                          style: TextStyle(
                            color: isDark
                                ? Colors.white
                                : const Color(0xff2B1E5E),
                          ),
                        ),
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
                        title: Text(
                          "العربية",
                          style: TextStyle(
                            color: isDark
                                ? Colors.white
                                : const Color(0xff2B1E5E),
                          ),
                        ),
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
          subtitle: 'Clear Data'.tr(),
          iconColor: Colors.redAccent,
          onTap: () =>
              showDialog(context: context, builder: (_) => ClearDialog()),
        ),
        BuildTile(
          icon: Icons.refresh,
          title: 'reset period'.tr(),
          subtitle: "Start new target".tr(),
          iconColor: Colors.orange,
          onTap: () =>
              showDialog(context: context, builder: (_) => ResetDialog()),
        ),
      ],
    );
  }
}
