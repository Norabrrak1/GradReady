import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ready/features/company/cubit/company_cubit.dart';
import 'package:grad_ready/features/splash/view.dart';
import 'package:grad_ready/features/user/cubit/user_cubit.dart';
import 'package:grad_ready/shared/network/local/bloc_observer.dart';
import 'package:grad_ready/shared/network/local/shared_preferences.dart';
import 'package:grad_ready/shared/styles/theme.dart';

import 'features/admin/cubit/admin_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  runApp(const MyApp());
}

String testEmail(String test) {
  return test;
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AdminCubit>(
              lazy: false, create: (BuildContext context) => AdminCubit()),
          BlocProvider<CompanyCubit>(
              lazy: false, create: (BuildContext context) => CompanyCubit()),
          BlocProvider<UserCubit>(
              lazy: false, create: (BuildContext context) => UserCubit()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          home: const Scaffold(
            body: SplashScreen(),
          ),
        ));
  }
}
