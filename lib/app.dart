import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:targetly/core/routing/app_router.dart';
import 'package:targetly/core/routing/routs.dart';
import 'package:targetly/core/theme/app_theme.dart';
import 'package:targetly/logic/Clients/cubit/client_cubit.dart';
import 'package:targetly/logic/activity/cubit/recentactivity_cubit.dart';
import 'package:targetly/logic/target/target_cubit/cubit/target_cubit.dart';
import 'package:targetly/logic/thems/cubit/thems_cubit.dart';
import 'package:targetly/logic/user/cubit/user_cubit.dart';

class Targeylyapp extends StatelessWidget {
  const Targeylyapp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ClinetCubit()),
        BlocProvider(create: (context) => TargetCubit()),
        BlocProvider(create: (context) => ActivityCubit()),
        BlocProvider(create: (context) => ThemsCubit()),
        BlocProvider(create: (context) => UserCubit()),
      ],
      child: BlocBuilder<ThemsCubit, ThemsState>(
        builder: (context, themeState) {
          final themeMode = context.read<ThemsCubit>().currentTheme;
          final isArabic = context.locale == const Locale('ar');

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            themeMode: themeMode,
            theme: AppTheme.lightTheme(isArabic),
            darkTheme: AppTheme.darkTheme(isArabic),
            initialRoute: AppRoutes.splashScreen,
            onGenerateRoute: AppRouter().ongenerateRoute,
          );
        },
      ),
    );
  }
}
