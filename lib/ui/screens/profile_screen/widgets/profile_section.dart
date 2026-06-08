// ProfileSection
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:targetly/logic/user/cubit/user_cubit.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        final username = state is UserLoaded
            ? state.user?.username ?? 'User'
            : 'User';
        final jobTitle = state is UserLoaded
            ? state.user?.jobTitle ?? 'Sales Manager'
            : 'Sales Manager';

        return Column(
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF7F73E6),
                    Color.fromARGB(255, 13, 157, 201),
                  ],
                ),
              ),
              child: const Icon(Icons.person, size: 45, color: Colors.white),
            ),
            const SizedBox(height: 18),
            Text(
              username,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : const Color(0xff2B1E5E),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              decoration: BoxDecoration(
                color: const Color(0xFF7F73E6).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                jobTitle,
                style: const TextStyle(
                  color: Color(0xFF7F73E6),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
