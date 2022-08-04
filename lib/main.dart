import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nike_store/data/product.dart';
import 'package:nike_store/data/repo/auth_repository.dart';
import 'package:nike_store/data/repo/banner_repository.dart';
import 'package:nike_store/data/repo/product_repository.dart';
import 'package:nike_store/theme.dart';
import 'package:nike_store/ui/auth/auth.dart';
import 'package:nike_store/ui/home/home.dart';
import 'package:nike_store/ui/root.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  authRepository.loadAuthInfo();
  runApp(const MyApp());
}

const defultTextStyle = TextStyle(
    fontFamily: 'YekanBakh', color: LightThemeColors.primatyTextColor);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    productRepository.getAllProduct(ProductSort.latest).then((value) {
      debugPrint(value.toString());
    }).catchError((e) {
      debugPrint(e.toString());
    });

    bannerRepository.getBanners().then((value) {
      debugPrint(value.toString());
    }).catchError((e) {
      debugPrint(e.toString());
    });

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
                style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
              minimumSize: MaterialStateProperty.all(Size.fromHeight(56)),
              backgroundColor: MaterialStateProperty.all(LightThemeColors.primatyColor),
              foregroundColor:
                  MaterialStateProperty.all(Colors.white),
            )),
        inputDecorationTheme: InputDecorationTheme(
                labelStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: LightThemeColors.primatyColor,
                    ),
                    borderRadius: BorderRadius.circular(12))),
          snackBarTheme: SnackBarThemeData(
            backgroundColor:LightThemeColors.primatyColor,
              contentTextStyle: defultTextStyle.apply(
                color: Colors.white,
                )),
          textTheme: TextTheme(
              subtitle1: defultTextStyle.copyWith(
                  fontSize: 16, color: LightThemeColors.seccondryTextColor),
              bodyText2: defultTextStyle,
              button: defultTextStyle,
              caption: defultTextStyle.apply(
                  color: LightThemeColors.seccondryTextColor),
              headline6: defultTextStyle.copyWith(
                  fontWeight: FontWeight.bold, fontSize: 18)),
          colorScheme: const ColorScheme.light(
              primary: LightThemeColors.primatyColor,
              secondary: LightThemeColors.seccondryColor,
              onSecondary: Colors.white)),
      home:
          Directionality(textDirection: TextDirection.rtl, child: RootScreen()),
    );
  }
}
