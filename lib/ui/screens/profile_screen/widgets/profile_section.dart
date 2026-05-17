import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// PROFILE IMAGE
        Container(
          width: 90,
          height: 90,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Color(0xFF7F73E6), Color.fromARGB(255, 13, 157, 201)],
            ),
          ),
          child: const Icon(Icons.person, size: 45, color: Colors.white),
        ),

        const SizedBox(height: 18),

        /// USER NAME
        const Text(
          'Abdallah moussa',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 8),

        /// JOB TITLE
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),

          decoration: BoxDecoration(
            color: const Color(0xFF7F73E6).withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),

          child: Text(
            'seals manager'.tr(),
            style: const TextStyle(
              color: Color(0xFF7F73E6),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
