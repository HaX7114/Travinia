import 'package:flutter/material.dart';

class TraviniaApp extends StatelessWidget {
  const TraviniaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      theme: AppThemes.lightTheme,
      themeMode: ThemeMode.light,
      /// TODO: Add routes here
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
