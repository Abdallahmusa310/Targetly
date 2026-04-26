import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:targetly/core/routing/app_router.dart';
import 'package:targetly/core/routing/routs.dart';
import 'package:targetly/data/hive/hive_manager.dart';
import 'package:targetly/firebase_options.dart';
import 'package:targetly/logic/Clients/client_cubit/clinet_cubit.dart';
import 'package:targetly/logic/activity/cubit/recentactivity_cubit.dart';
import 'package:targetly/logic/target/target_cubit/cubit/target_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('Firebase initialized successfully');
  } catch (e) {
    print('Firebase initialization failed: $e');
    // Continue without Firebase if it fails
  }

  try {
    await HiveManager.init();
    print('Hive initialized successfully');
  } catch (e) {
    print('Hive initialization failed: $e');
    // Try to initialize Hive without adapters as fallback
    try {
      await Hive.initFlutter();
      print('Hive basic initialization successful');
    } catch (e2) {
      print('Hive basic initialization also failed: $e2');
    }
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ClinetCubit()),
        BlocProvider(create: (context) => TargetCubit()),
        BlocProvider(create: (context) => ActivityCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.splashScreen,
        onGenerateRoute: AppRouter().ongenerateRoute,
      ),
    );
  }
}
