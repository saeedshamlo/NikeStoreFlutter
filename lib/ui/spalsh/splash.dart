import 'package:flutter/material.dart';
import 'package:nike_store/ui/root.dart';
import 'package:rive/rive.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration(seconds: 3),
      () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Directionality(textDirection: TextDirection.rtl, child: RootScreen()),
        ));
        
      },
    );
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: Image.asset('assets/icon/icon.png')),
          SizedBox(
              width: 56,
              height: 56,
              child: RiveAnimation.asset('assets/riv/loading.riv')),
          SizedBox(
            height: 32,
          )
        ],
      ),
    );
  }
}
