import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_app/config/di/di.dart';
import 'package:tracking_app/core/constants/screen_size.dart';
import 'package:tracking_app/core/router/app_router.dart';
import 'package:tracking_app/core/theme/app_theme.dart';
import 'package:tracking_app/generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSize.intial(context);
    return MaterialApp.router(
      title: 'Florista Shop App',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [S.delegate],
      supportedLocales: S.delegate.supportedLocales,
      routerConfig: AppRouter.goRouter,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
    );
  }
}
