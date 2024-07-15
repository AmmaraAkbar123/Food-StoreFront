import 'package:flutter/material.dart';
import 'package:foodstorefront/provider/category_provider.dart';
import 'package:foodstorefront/provider/radio_provider.dart';
import 'package:foodstorefront/screens/splash_screen.dart';
import 'package:foodstorefront/screens/store_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => RadioProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
            // appBarTheme: const AppBarTheme(
            //   systemOverlayStyle: SystemUiOverlayStyle.light,
            // ),
            ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
