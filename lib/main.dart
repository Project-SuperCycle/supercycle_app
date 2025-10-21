import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:supercycle_app/core/cubits/local_cubit/local_cubit.dart';
import 'package:supercycle_app/core/cubits/social_auth/social_auth_cubit.dart';
import 'package:supercycle_app/core/repos/social_auth_repo_imp.dart';
import 'package:supercycle_app/core/routes/routes.dart';
import 'package:supercycle_app/core/services/services_locator.dart';
import 'package:supercycle_app/features/home/data/managers/home_cubit/home_cubit.dart';
import 'package:supercycle_app/features/home/data/repos/home_repo_imp.dart';
import 'package:supercycle_app/features/representative_shipment_details/data/cubits/accept_shipment_cubit/accept_shipment_cubit.dart';
import 'package:supercycle_app/features/representative_shipment_details/data/cubits/reject_shipment_cubit/reject_shipment_cubit.dart';
import 'package:supercycle_app/features/representative_shipment_details/data/cubits/update_shipment_cubit/update_shipment_cubit.dart';
import 'package:supercycle_app/features/representative_shipment_details/data/repos/rep_shipment_details_repo_imp.dart';
import 'package:supercycle_app/features/representative_shipment_review/data/cubits/deliver_segment_cubit/deliver_segment_cubit.dart';
import 'package:supercycle_app/features/representative_shipment_review/data/cubits/fail_segment_cubit/fail_segment_cubit.dart';
import 'package:supercycle_app/features/representative_shipment_review/data/cubits/start_segment_cubit/start_segment_cubit.dart';
import 'package:supercycle_app/features/representative_shipment_review/data/cubits/weigh_segment_cubit/weigh_segment_cubit.dart';
import 'package:supercycle_app/features/representative_shipment_review/data/repos/rep_shipment_review_repo_imp.dart';
import 'package:supercycle_app/features/trader_shipment_details/data/cubits/notes_cubit/notes_cubit.dart';
import 'package:supercycle_app/features/trader_shipment_details/data/cubits/shipment_cubit/shipment_cubit.dart';
import 'package:supercycle_app/features/trader_shipment_details/data/repos/shipment_details_repo_imp.dart';
import 'package:supercycle_app/features/trader_shipment_details/data/repos/shipment_notes_repo_imp.dart';
import 'package:supercycle_app/features/shipment_edit/data/cubits/shipment_edit_cubit.dart';
import 'package:supercycle_app/features/shipment_edit/data/repos/shipment_edit_repo_imp.dart';
import 'package:supercycle_app/features/shipment_preview/data/cubits/create_shipment_cubit/create_shipment_cubit.dart';
import 'package:supercycle_app/features/shipment_preview/data/repos/shipment_preview_repo_imp.dart';
import 'package:supercycle_app/features/shipments_calendar/data/cubits/shipments_calendar_cubit/shipments_calendar_cubit.dart';
import 'package:supercycle_app/features/shipments_calendar/data/repos/shipments_calendar_repo_imp.dart';
import 'package:supercycle_app/features/sign_in/data/cubits/sign-in-cubit/sign_in_cubit.dart';
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
          create: (context) {
            final cubit = HomeCubit(homeRepo: getIt.get<HomeRepoImp>());
            WidgetsBinding.instance.addPostFrameCallback((_) {
              cubit.fetchTypesData();
              cubit.fetchDoshTypes();
            });
            return cubit;
          },
        ),

        BlocProvider(
          create: (context) => CreateShipmentCubit(
            shipmentReviewRepo: getIt.get<ShipmentReviewRepoImp>(),
          ),
        ),

        BlocProvider(
          create: (context) => ShipmentCubit(
            shipmentDetailsRepo: getIt.get<ShipmentDetailsRepoImp>(),
          ),
        ),

        BlocProvider(
          create: (context) =>
              NotesCubit(shipmentNotesRepo: getIt.get<ShipmentNotesRepoImp>()),
        ),

        BlocProvider(
          create: (context) {
            final cubit = ShipmentsCalendarCubit(
              shipmentsCalendarRepo: getIt.get<ShipmentsCalendarRepoImp>(),
            );
            WidgetsBinding.instance.addPostFrameCallback((_) {
              cubit.getAllShipments();
            });
            return cubit;
          },
        ),

        BlocProvider(
          create: (context) => ShipmentEditCubit(
            shipmentEditRepo: getIt.get<ShipmentEditRepoImp>(),
          ),
        ),

        BlocProvider(
          create: (context) => AcceptShipmentCubit(
            repShipmentDetailsRepo: getIt.get<RepShipmentDetailsRepoImp>(),
          ),
        ),
        BlocProvider(
          create: (context) => RejectShipmentCubit(
            repShipmentDetailsRepo: getIt.get<RepShipmentDetailsRepoImp>(),
          ),
        ),
        BlocProvider(
          create: (context) => UpdateShipmentCubit(
            repShipmentDetailsRepo: getIt.get<RepShipmentDetailsRepoImp>(),
          ),
        ),
        BlocProvider(
          create: (context) => StartSegmentCubit(
            repShipmentReviewRepo: getIt.get<RepShipmentReviewRepoImp>(),
          ),
        ),
        BlocProvider(
          create: (context) => WeighSegmentCubit(
            repShipmentReviewRepo: getIt.get<RepShipmentReviewRepoImp>(),
          ),
        ),
        BlocProvider(
          create: (context) => DeliverSegmentCubit(
            repShipmentReviewRepo: getIt.get<RepShipmentReviewRepoImp>(),
          ),
        ),
        BlocProvider(
          create: (context) => FailSegmentCubit(
            repShipmentReviewRepo: getIt.get<RepShipmentReviewRepoImp>(),
          ),
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
            theme: ThemeData(scaffoldBackgroundColor: Colors.white),
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
