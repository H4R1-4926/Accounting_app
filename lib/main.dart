import 'package:curved_nav/Application/Advertisment/ad_bloc.dart';
import 'package:curved_nav/Application/Calender/calender_bloc.dart';
import 'package:curved_nav/Application/Category/category_bloc.dart';
import 'package:curved_nav/Application/Expense/expense_bloc.dart';
import 'package:curved_nav/Application/Lender/lender_bloc.dart';
import 'package:curved_nav/Application/Splash%20Screen/splash_bloc.dart';
import 'package:curved_nav/Infrastructure/App%20Install%20and%20Uninstall/app_clear.dart';

import 'package:curved_nav/Infrastructure/User/user_repository.dart';
import 'package:curved_nav/domain/core/d_i/injectable.dart';
import 'package:curved_nav/domain/models/Expense%20model/expense_model.dart';
import 'package:curved_nav/domain/models/category%20model/category_model.dart';
import 'package:curved_nav/firebase_options.dart';
import 'package:curved_nav/view/utils/Introduction%20screen/onBoarding_screen.dart';
import 'package:curved_nav/view/utils/Navigation/nav_screen.dart';

import 'package:curved_nav/view/utils/color_constant/color_constant.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await configInjectable();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }
  if (!Hive.isAdapterRegistered(ExpenseModelAdapter().typeId)) {
    Hive.registerAdapter(ExpenseModelAdapter());
  }
  await UserRepository().handleUserRegistration();
  await AppClear().performPeriodicCleanup();
  await GetStorage.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    bool isFirstTime = box.read('first_time') ?? true;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getit<CategoryBloc>(),
        ),
        BlocProvider(
          create: (context) => getit<ExpenseBloc>(),
        ),
        BlocProvider(
          create: (context) => getit<LenderBloc>(),
        ),
        BlocProvider(
          create: (context) => CalenderBloc(),
        ),
        BlocProvider(
          create: (context) => SplashBloc(),
        ),
        BlocProvider(
          create: (context) => AdBloc(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: white),
        debugShowCheckedModeBanner: false,
        home: isFirstTime ? OnboardingScreen() : NavScreen(),
      ),
    );
  }
}
