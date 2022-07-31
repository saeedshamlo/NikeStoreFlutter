import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    const onBackground = Colors.white;
    return Theme(
      data: themeData.copyWith(
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12))),
            minimumSize: MaterialStateProperty.all(Size.fromHeight(56)),
            backgroundColor: MaterialStateProperty.all(onBackground),
            foregroundColor:
                MaterialStateProperty.all(themeData.colorScheme.secondary),
          )),
          colorScheme: themeData.colorScheme.copyWith(onSurface: onBackground),
          inputDecorationTheme: InputDecorationTheme(
              labelStyle: TextStyle(color: onBackground),
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: onBackground,
                  ),
                  borderRadius: BorderRadius.circular(12)))),
      child: Scaffold(
        backgroundColor: themeData.colorScheme.secondary,
        body: Padding(
          padding: const EdgeInsets.only(left: 48, right: 48),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/img/nike_logo.png',
                color: onBackground,
                width: 120,
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                isLogin ? 'خوش آمدید' : 'ثبت نام',
                style: TextStyle(
                    color: onBackground,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                isLogin
                    ? 'لطفا وارد حساب کاربری خود شوید'
                    : 'ایمیل و رمز عبور خود را تعیین کنید',
                style: TextStyle(color: onBackground, fontSize: 16),
              ),
              SizedBox(
                height: 24,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(label: Text('آدرس ایمیل')),
              ),
              SizedBox(
                height: 16,
              ),
              _PasswordTextField(onBackground: onBackground),
              SizedBox(
                height: 16,
              ),
              ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    isLogin?'ورود':'ثبت نام',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  )),
              SizedBox(
                height: 8,
              ),
              InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  setState(() {
                    isLogin =!isLogin;
                  });
                },
                child: Container(
                  height: 56,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    
                      Text(
                        isLogin?'حساب کاربری ندارید؟':'حساب کاربری دارید؟',
                        style: TextStyle(color: onBackground.withOpacity(0.7)),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        isLogin?'ثبت نام':'ورود',
                        style: TextStyle(
                            color: themeData.colorScheme.primary,
                            decoration: TextDecoration.underline),
                      ),
                     
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _PasswordTextField extends StatefulWidget {
  const _PasswordTextField({
    Key? key,
    required this.onBackground,
  }) : super(key: key);

  final Color onBackground;

  @override
  State<_PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<_PasswordTextField> {
  bool onsecureText = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
        obscureText: onsecureText,
        obscuringCharacter: '*',
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
            suffixIcon: IconButton(
              splashRadius: 20,
                onPressed: () {
                  setState(() {
                    onsecureText = !onsecureText;
                  });
                },
                icon: Icon(
                  onsecureText
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: widget.onBackground.withOpacity(0.6),
                )),
            label: Text('رمز عبور')));
  }
}
