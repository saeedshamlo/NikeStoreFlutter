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
          useMaterial3: true,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.white),
              backgroundColor: MaterialStateProperty.all(LightThemeColors.primatyColor),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)
              ))
            )
          ),
        
          outlinedButtonTheme: 
          OutlinedButtonThemeData(
            style: ButtonStyle(
                    shape: MaterialStateProperty.all( RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)
                    )),
                    side: MaterialStateProperty.all(BorderSide(
                        color: Colors.blue.withOpacity(0.1),
                        width: 1.0,
                        style: BorderStyle.solid))
                  )
          ),
          highlightColor: LightThemeColors.seccondryTextColor,
          appBarTheme: AppBarTheme(
            centerTitle: false,
              backgroundColor: Colors.white,
              foregroundColor: LightThemeColors.primatyTextColor,
              elevation: 0),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: LightThemeColors.seccondryColor),
            
          inputDecorationTheme: InputDecorationTheme(
              labelStyle: TextStyle(color: Colors.black.withOpacity(0.5),fontFamily:"YekanBakh" ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: LightThemeColors.primatyTextColor.withOpacity(0.1)
                )
              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: LightThemeColors.primatyColor,
                  ),
                  )),
          snackBarTheme: SnackBarThemeData(
              backgroundColor: LightThemeColors.primatyColor,
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
