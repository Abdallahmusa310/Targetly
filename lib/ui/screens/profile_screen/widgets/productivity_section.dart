import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:targetly/ui/screens/home_screen/widgets/target_dialog.dart';
import 'package:targetly/ui/screens/profile_screen/widgets/build_tile.dart';

class ProductivitySection extends StatelessWidget {
  const ProductivitySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BuildTile(
          icon: Icons.flag,
          title: "Set Target".tr(),
          subtitle: "Update your target".tr(),
          onTap: () {
            Navigator.pop(context);

            showDialog(context: context, builder: (_) => const Targetdialog());
          },
        ),
      ],
    );
  }
}
