import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:nike_store/data/repo/auth_repository.dart';
import 'package:nike_store/ui/auth/bloc/auth_bloc.dart';

class AuthScreen extends StatefulWidget {
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController usernameController =
      TextEditingController(text: "test@gmail.com");
  final TextEditingController passwordController =
      TextEditingController(text: "123456");
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    const onBackground = Colors.white;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Theme(
        data: themeData.copyWith(
            snackBarTheme: SnackBarThemeData(
                backgroundColor: themeData.colorScheme.primary,
                contentTextStyle: TextStyle(fontFamily: 'YekanBakh')),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
              minimumSize: MaterialStateProperty.all(Size.fromHeight(56)),
              backgroundColor: MaterialStateProperty.all(onBackground),
              foregroundColor:
                  MaterialStateProperty.all(themeData.colorScheme.secondary),
            )),
            colorScheme:
                themeData.colorScheme.copyWith(onSurface: onBackground),
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
          body: BlocProvider<AuthBloc>(
            create: (context) {
              final bloc = AuthBloc(authRepository);
              bloc.stream.forEach((state) {
                if (state is AuthSuccess) {
                  Navigator.of(context).pop();
                } else if (state is AuthError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.exception.message)));
                }
              });
              bloc.add(AuthStarted());
              return bloc;
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 48, right: 48),
              child: BlocBuilder<AuthBloc, AuthState>(
                buildWhen: (previous, current) {
                  return current is AuthLoading ||
                      current is AuthInitial ||
                      current is AuthError;
                },
                builder: (context, state) {
                  return Column(
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
                        state.isLoginMode ? 'خوش آمدید' : 'ثبت نام',
                        style: TextStyle(
                            color: onBackground,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        state.isLoginMode
                            ? 'لطفا وارد حساب کاربری خود شوید'
                            : 'ایمیل و رمز عبور خود را تعیین کنید',
                        style: TextStyle(color: onBackground, fontSize: 16),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      TextField(
                        controller: usernameController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(label: Text('آدرس ایمیل')),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      _PasswordTextField(
                        onBackground: onBackground,
                        passwordController: passwordController,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<AuthBloc>(context).add(
                                AuthButtonIsClicked(usernameController.text,
                                    passwordController.text));
                          },
                          child: state is AuthLoading
                              ? Lottie.asset('assets/anim/circularloader.json',
                                  height: 40, repeat: true)
                              : Text(
                                  state.isLoginMode ? 'ورود' : 'ثبت نام',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                )),
                      SizedBox(
                        height: 8,
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () {
                          BlocProvider.of<AuthBloc>(context)
                              .add(AuthModeChangeIsClicked());
                        },
                        child: Container(
                          height: 56,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                state.isLoginMode
                                    ? 'حساب کاربری ندارید؟'
                                    : 'حساب کاربری دارید؟',
                                style: TextStyle(
                                    color: onBackground.withOpacity(0.7)),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                state.isLoginMode ? 'ثبت نام' : 'ورود',
                                style: TextStyle(
                                    color: themeData.colorScheme.primary,
                                    decoration: TextDecoration.underline),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
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
    required this.passwordController,
  }) : super(key: key);

  final Color onBackground;
  final TextEditingController passwordController;

  @override
  State<_PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<_PasswordTextField> {
  bool onsecureText = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: widget.passwordController,
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
