import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:supercycle_app/core/cubits/local_cubit/local_cubit.dart';
import 'package:supercycle_app/core/cubits/social_auth/social_auth_cubit.dart';
import 'package:supercycle_app/core/repos/social_auth_repo_imp.dart';
import 'package:supercycle_app/core/routes/routes.dart' show AppRouter;
import 'package:supercycle_app/core/services/services_locator.dart';
import 'package:supercycle_app/features/home/data/managers/home_cubit/home_cubit.dart';
import 'package:supercycle_app/features/home/data/repos/home_repo_imp.dart';
import 'package:supercycle_app/features/sign_in/data/managers/sign-in-cubit/sign_in_cubit.dart';
import 'package:supercycle_app/features/sign_in/data/repos/signin_repo_imp.dart';
import 'package:supercycle_app/features/sign_up/data/managers/sign_up_cubit/sign_up_cubit.dart'
    show SignUpCubit;
import 'package:supercycle_app/features/sign_up/data/repos/signup_repo_imp.dart'
    show SignUpRepoImp;
import 'package:supercycle_app/firebase_options.dart'
    show DefaultFirebaseOptions;

import 'generated/l10n.dart';

void main() async {
  setupServiceLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LocalCubit()),
        BlocProvider(
          create: (context) =>
              SignInCubit(signInRepo: getIt.get<SignInRepoImp>()),
        ),
        BlocProvider(
          create: (context) =>
              SignUpCubit(signUpRepo: getIt.get<SignUpRepoImp>()),
        ),
        BlocProvider(
          create: (context) =>
              SocialAuthCubit(socialAuthRepo: getIt.get<SocialAuthRepoImp>()),
        ),
        BlocProvider(
          create: (context) => HomeCubit(homeRepo: getIt.get<HomeRepoImp>()),
        ),
      ],

      // child: DevicePreview(
      //   enabled: true,
      //   builder: (context) {
      //     return const MyApp();
      //   },
      // ),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocalCubit()..getSavedLang(),
      child: BlocBuilder<LocalCubit, LocalState>(
        builder: (context, state) {
          return MaterialApp.router(
            routerConfig: AppRouter.router,
            locale: (state is ChangeLocalState)
                ? const Locale('ar')
                : const Locale('ar'),
            builder: DevicePreview.appBuilder,
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
          );
        },
      ),
    );
  }
}
