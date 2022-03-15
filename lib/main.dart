import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:receipts/base/business_logic/auth/auth_bloc/auth_bloc.dart';
import 'package:receipts/base/business_logic/auth/auth_repo.dart';
import 'package:receipts/firebase_options.dart';
import 'package:receipts/receipt_theme.dart';
import 'package:receipts/routes.dart';

Future<void> main() {
  return BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      final authenticationRepository = AuthenticationRepository();
      await authenticationRepository.user.first;
      runApp(
        RepositoryProvider.value(
          value: authenticationRepository,
          child: BlocProvider(
            create: (context) => AuthBloc(
              authenticationRepository: authenticationRepository,
            ),
            child: const ReceiptsApp(),
          ),
        ),
      );
    },
    // blocObserver: AppBlocObserver(),
  );
}

/// ----------------------------------------------------------------------------
/// Material App
/// ----------------------------------------------------------------------------
class ReceiptsApp extends StatelessWidget {
  ///
  const ReceiptsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (BuildContext context) =>
          AppLocalizations.of(context)!.title,
      routerDelegate: Routes.router(context).routerDelegate,
      routeInformationParser: Routes.router(context).routeInformationParser,
      darkTheme: ReceiptTheme.dark,
      theme: ReceiptTheme.light,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
