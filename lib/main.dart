import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tracking_app/config/di/di.dart';
import 'package:tracking_app/core/constants/screen_size.dart';
import 'package:tracking_app/core/locale/locale_cubit.dart';
import 'package:tracking_app/core/router/app_router.dart';
import 'package:tracking_app/core/theme/app_theme.dart';
import 'package:tracking_app/firebase_options.dart';
import 'package:tracking_app/generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Same Firebase project (track-app-d33ab) as the Florista app. This app
  // writes driver/order status updates to Firestore; the Florista app
  // listens to those same documents to show live tracking to customers.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await configureDependencies();
  // Load the last saved locale from SharedPreferences before the app starts.
  final savedLocale = await LocaleCubit.loadSavedLocale();

  runApp(
    BlocProvider(create: (_) => LocaleCubit(savedLocale), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSize.intial(context);
    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, locale) {
        return MaterialApp.router(
          title: 'Tracking App',
          debugShowCheckedModeBanner: false,
          locale: locale,
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          routerConfig: AppRouter.goRouter,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system, // Use system theme mode
        );
      },
    );
  }
}