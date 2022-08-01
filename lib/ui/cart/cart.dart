import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_store/data/auth_info.dart';
import 'package:nike_store/data/repo/auth_repository.dart';
import 'package:nike_store/ui/auth/auth.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('سبد خرید'),
      ),
      body: ValueListenableBuilder<AuthInfo?>(
        valueListenable: AuthRepository.authChangeNotifier,
        builder: (context, state, child) {
          bool isAuthenticated = state != null && state.accessToken.isNotEmpty;
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(isAuthenticated
                      ? 'خوش آمدید'
                      : 'لطفا وارد حساب کاربری خود شوید'),
                  isAuthenticated
                      ? ElevatedButton(
                          onPressed: () {
                            authRepository.signOut();
                          },
                          child: Text('خروج از حساب کاربری'),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true)
                                .push(MaterialPageRoute(
                              builder: (context) => AuthScreen(),
                            ));
                          },
                          child: Text('ورود'),
                        ),
                        ElevatedButton(
                          onPressed: ()async {
                            await authRepository.refreshToken();
                            
                          },
                          child: Text('Refresh Token')),
                ]),
          );
        },
      ),
    );
  }
}
