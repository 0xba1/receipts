import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:receipts/ads/ads_controller.dart';
import 'package:receipts/ads/ads_cubit.dart';
import 'package:receipts/base/business_logic/auth/auth_bloc/auth_bloc.dart';
import 'package:receipts/base/business_logic/auth/auth_repo.dart';
import 'package:receipts/base/business_logic/database/database.dart';
import 'package:receipts/base/business_logic/receipts/receipts_bloc/receipts_bloc.dart';
import 'package:receipts/base/business_logic/search/search_cubit.dart';
import 'package:receipts/firebase_options.dart';
import 'package:receipts/receipt_theme.dart';
import 'package:receipts/routes.dart';

void main() {
  return BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      final authenticationRepository = AuthenticationRepository();
      await authenticationRepository.user.first;

      final adsController = AdsController(MobileAds.instance);
      unawaited(adsController.initialize());
      final database = FireDatabase();

      runApp(
        MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AuthBloc(
                authenticationRepository: authenticationRepository,
              ),
              lazy: false,
            ),
            BlocProvider(
              create: (_) => ReceiptsBloc(
                authenticationRepository: authenticationRepository,
                database: database,
              ),
            ),
            BlocProvider(
              create: (_) => AdsCubit(adsController),
            ),
            BlocProvider(
              create: (context) {
                final receiptsBloc = context.read<ReceiptsBloc>();
                return SearchCubit(receiptsBloc);
              },
            ),
          ],
          child: const ReceiptsApp(),
        ),
      );
    },
    // blocObserver: AppBlocObserver(),
  );
}

/// {@template app}
/// Material App
/// {@end_template app}
class ReceiptsApp extends StatelessWidget {
  /// {@macro app}
  const ReceiptsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        onGenerateTitle: (BuildContext context) =>
            AppLocalizations.of(context)!.title,
        routerDelegate: Routes.router(context).routerDelegate,
        routeInformationParser: Routes.router(context).routeInformationParser,
        darkTheme: ReceiptTheme.dark,
        theme: ReceiptTheme.light,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}
