import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:supercycle/core/cubits/add_notes_cubit/add_notes_cubit.dart';
import 'package:supercycle/core/cubits/all_notes_cubit/all_notes_cubit.dart';
import 'package:supercycle/core/cubits/local_cubit/local_cubit.dart';
import 'package:supercycle/core/cubits/social_auth/social_auth_cubit.dart';
import 'package:supercycle/core/repos/social_auth_repo_imp.dart';
import 'package:supercycle/core/routes/routes.dart';
import 'package:supercycle/core/services/services_locator.dart';
import 'package:supercycle/features/environment/data/cubits/eco_cubit/eco_cubit.dart';
import 'package:supercycle/features/environment/data/repos/environment_repo_imp.dart';
import 'package:supercycle/features/home/data/managers/home_cubit/home_cubit.dart';
import 'package:supercycle/features/home/data/managers/shipments_cubit/today_shipments_cubit.dart';
import 'package:supercycle/features/home/data/repos/home_repo_imp.dart';
import 'package:supercycle/features/representative_shipment_details/data/cubits/accept_shipment_cubit/accept_shipment_cubit.dart';
import 'package:supercycle/features/representative_shipment_details/data/cubits/reject_shipment_cubit/reject_shipment_cubit.dart';
import 'package:supercycle/features/representative_shipment_details/data/cubits/update_shipment_cubit/update_shipment_cubit.dart';
import 'package:supercycle/features/representative_shipment_details/data/repos/rep_shipment_details_repo_imp.dart';
import 'package:supercycle/features/representative_shipment_review/data/cubits/deliver_segment_cubit/deliver_segment_cubit.dart';
import 'package:supercycle/features/representative_shipment_review/data/cubits/fail_segment_cubit/fail_segment_cubit.dart';
import 'package:supercycle/features/representative_shipment_review/data/cubits/start_segment_cubit/start_segment_cubit.dart';
import 'package:supercycle/features/representative_shipment_review/data/cubits/weigh_segment_cubit/weigh_segment_cubit.dart';
import 'package:supercycle/features/representative_shipment_review/data/repos/rep_shipment_review_repo_imp.dart';
import 'package:supercycle/features/trader_shipment_details/data/cubits/shipment_cubit/shipment_cubit.dart';
import 'package:supercycle/features/trader_shipment_details/data/repos/shipment_details_repo_imp.dart';
import 'package:supercycle/features/trader_shipment_details/data/repos/shipment_notes_repo_imp.dart';
import 'package:supercycle/features/shipment_edit/data/cubits/shipment_edit_cubit.dart';
import 'package:supercycle/features/shipment_edit/data/repos/shipment_edit_repo_imp.dart';
import 'package:supercycle/features/shipments_calendar/data/cubits/shipments_calendar_cubit/shipments_calendar_cubit.dart';
import 'package:supercycle/features/shipments_calendar/data/repos/shipments_calendar_repo_imp.dart';
import 'package:supercycle/features/sign_in/data/cubits/sign-in-cubit/sign_in_cubit.dart';
import 'package:supercycle/features/sign_in/data/repos/signin_repo_imp.dart';
import 'package:supercycle/features/sign_up/data/managers/sign_up_cubit/sign_up_cubit.dart'
    show SignUpCubit;
import 'package:supercycle/features/sign_up/data/repos/signup_repo_imp.dart'
    show SignUpRepoImp;
import 'package:supercycle/features/trader_shipment_preview/data/cubits/create_shipment_cubit/create_shipment_cubit.dart';
import 'package:supercycle/features/trader_shipment_preview/data/repos/trader_shipment_preview_repo_imp.dart';
import 'package:supercycle/firebase_options.dart' show DefaultFirebaseOptions;

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
            // Call methods once when app starts
            cubit.fetchTypesData();
            cubit.fetchDoshTypes();
            cubit.fetchTypeHistory(typeId: "68a8567bf5a2951a1ee9e982");
            return cubit;
          },
        ),

        BlocProvider(
          create: (context) => CreateShipmentCubit(
            shipmentReviewRepo: getIt.get<TraderShipmentPreviewRepoImp>(),
          ),
        ),

        BlocProvider(
          create: (context) => ShipmentCubit(
            shipmentDetailsRepo: getIt.get<ShipmentDetailsRepoImp>(),
          ),
        ),

        BlocProvider(
          create: (context) => AllNotesCubit(
            shipmentNotesRepo: getIt.get<ShipmentNotesRepoImp>(),
          ),
        ),

        BlocProvider(
          create: (context) => AddNotesCubit(
            shipmentNotesRepo: getIt.get<ShipmentNotesRepoImp>(),
          ),
        ),

        BlocProvider(
          create: (context) => ShipmentsCalendarCubit(
            shipmentsCalendarRepo: getIt.get<ShipmentsCalendarRepoImp>(),
          ),
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
        BlocProvider(
          create: (context) {
            final cubit = TodayShipmentsCubit(
              homeRepo: getIt.get<HomeRepoImp>(),
            );
            // Call methods once when app starts
            cubit.fetchTodayShipments();
            return cubit;
          },
        ),

        BlocProvider(
          create: (context) =>
              EcoCubit(environmentRepoImp: getIt.get<EnvironmentRepoImp>()),
        ),
      ],

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
