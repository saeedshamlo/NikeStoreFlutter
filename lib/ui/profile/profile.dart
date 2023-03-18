import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_store/data/auth_info.dart';
import 'package:nike_store/data/repo/auth_repository.dart';
import 'package:nike_store/data/repo/cart_repository.dart';
import 'package:nike_store/ui/auth/auth.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('پروفایل'),
      ),
      body: ValueListenableBuilder<AuthInfo?>(
          valueListenable: AuthRepository.authChangeNotifier,
          builder: (context, authInfo, child) {
            final isLogin = authInfo != null && authInfo.accessToken.isNotEmpty;
            return Column(
              children: [
                SizedBox(
                  height: 32,
                ),
                Container(
                  height: 65,
                  width: 65,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(33),
                      border:
                          Border.all(color: Theme.of(context).dividerColor)),
                  child: Image.asset('assets/img/nike_logo.png'),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(isLogin ? authInfo.email : 'کاربر مهمان'),
                SizedBox(
                  height: 32,
                ),
                Divider(
                  color: Theme.of(context).dividerColor,
                  height: 1,
                ),
                RowItems(
                  rowName: 'لیست علاقه مندی ها',
                  icon: CupertinoIcons.heart,
                  callback: () {},
                ),
                Divider(
                  color: Theme.of(context).dividerColor,
                  height: 1,
                ),
                RowItems(
                  rowName: 'سوابق سفارش',
                  icon: CupertinoIcons.cart,
                  callback: () {},
                ),
                Divider(
                  color: Theme.of(context).dividerColor,
                  height: 1,
                ),
                RowItems(
                  rowName:
                      isLogin ? 'خروج از حساب کاربری' : 'ورود به حساب کاربری',
                  icon: isLogin
                      ? CupertinoIcons.arrow_right_square
                      : CupertinoIcons.arrow_left_square,
                  callback: () {
                    isLogin
                        ? showDialog(
                            context: context,
                            useRootNavigator: true,
                            builder: (context) {
                              return Directionality(
                                textDirection: TextDirection.rtl,
                                child: AlertDialog(
                                  title: Text('خروج از حساب کاربری'),
                                  content: Text(
                                      'آیا میخواهید از حساب خود خارج شوید؟'),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('خیر')),
                                    TextButton(
                                        onPressed: () {
                                          authRepository.signOut();
                                          CartRepository
                                              .cartItemCountNotifier.value = 0;
                                          Navigator.pop(context);
                                        },
                                        child: Text('بله')),
                                  ],
                                ),
                              );
                            })
                        : Navigator.of(context,rootNavigator: true).push(MaterialPageRoute(builder: (context) => AuthScreen(),));
                  },
                ),
                Divider(
                  color: Theme.of(context).dividerColor,
                  height: 1,
                ),
              ],
            );
          }),
    );
  }
}

class RowItems extends StatelessWidget {
  const RowItems({
    super.key,
    required this.rowName,
    required this.icon,
    required this.callback,
  });

  final GestureTapCallback callback;
  final String rowName;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        height: 56,
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Row(
          children: [
            Icon(icon),
            SizedBox(
              width: 8,
            ),
            Text(rowName)
          ],
        ),
      ),
    );
  }
}
