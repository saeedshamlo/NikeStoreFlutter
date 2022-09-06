import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nike_store/common/utils.dart';
import 'package:nike_store/data/auth_info.dart';
import 'package:nike_store/data/cart_item.dart';
import 'package:nike_store/data/repo/auth_repository.dart';
import 'package:nike_store/data/repo/cart_repository.dart';
import 'package:nike_store/ui/auth/auth.dart';
import 'package:nike_store/ui/cart/bloc/cart_bloc.dart';
import 'package:nike_store/ui/cart/cart_items.dart';
import 'package:nike_store/ui/cart/price_info.dart';
import 'package:nike_store/ui/widget/empty_state.dart';
import 'package:nike_store/ui/widget/error.dart';
import 'package:nike_store/ui/widget/image.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late final CartBloc? cartBloc;
  final RefreshController refreshControler = RefreshController();
  StreamSubscription? streamSubscription;
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    AuthRepository.authChangeNotifier.addListener(authChangeNotifierListener);
  }

  void authChangeNotifierListener() {
    cartBloc?.add(CartAuthInfoChanged(AuthRepository.authChangeNotifier.value));
  }

  @override
  void dispose() {
    AuthRepository.authChangeNotifier
        .removeListener(authChangeNotifierListener);
    cartBloc?.close();
    streamSubscription?.cancel();
    scaffoldMessengerKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text('سبد خرید'),
        ),
        body: BlocProvider<CartBloc>(
          create: (context) {
            final bloc = CartBloc(cartRepository);
            streamSubscription = bloc.stream.listen((state) {
              if (refreshControler.isRefresh) {
                if (state is CartSuccess) {
                  refreshControler.refreshCompleted();
                } else if (state is CartError) {
                  refreshControler.refreshFailed();
                }
              }
              if (state is CartChangeError) {
                scaffoldMessengerKey.currentState?.showSnackBar(
                    SnackBar(content: Text(state.appException.message!)));
              }
            });
            cartBloc = bloc;
            bloc.add(CartStarted(AuthRepository.authChangeNotifier.value));
            return bloc;
          },
          child: BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is CartError) {
                return SmartRefresher(
                  controller: refreshControler,
                  onRefresh: (() {
                    cartBloc?.add(CartStarted(
                        AuthRepository.authChangeNotifier.value,
                        isRefreshing: true));
                  }),
                  child:  AppErrorWidget(
                  appException: state.appException,
                  onTryAgainClick: () {
                    BlocProvider.of<CartBloc>(context).add(CartStarted(AuthRepository.authChangeNotifier.value,
                        isRefreshing: true));
                  },
                )
                );
              } else if (state is CartSuccess) {
                return SmartRefresher(
                  controller: refreshControler,
                  header: ClassicHeader(
                    refreshStyle: RefreshStyle.Follow,
                    completeText: 'با موفقیت انجام شد',
                    refreshingText: 'درحال بروزرسانی',
                    idleText: 'برای بروزرسانی پایین بکشید',
                    releaseText: 'رها کنید',
                    failedText: 'خطای نامشخص',
                    spacing: 2,
                  ),
                  onRefresh: (() {
                    cartBloc?.add(CartStarted(
                        AuthRepository.authChangeNotifier.value,
                        isRefreshing: true));
                  }),
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (index < state.cartResponse.cartItems.length) {
                        final data = state.cartResponse.cartItems[index];
                        return CartItem(
                          data: data,
                          onDeleteButttonClick: () {
                            cartBloc?.add(CartDeleteButtonClicked(data.id));
                          },
                          onIncButttonClick: () {
                            cartBloc?.add(CartIncCountButtonClicked(data.id));
                          },
                          onDecButttonClick: () {
                            if (data.count > 1) {
                              cartBloc?.add(CartDecCountButtonClicked(data.id));
                            }
                          },
                        );
                      } else {
                        return PriceInfo(
                          payblePrice: state.cartResponse.payblePrice,
                          totalPrice: state.cartResponse.totalPrice,
                          shippingCost: state.cartResponse.shippingCost,
                        );
                      }
                    },
                    itemCount: state.cartResponse.cartItems.length + 1,
                  ),
                );
              } else if (state is CartAuthRequired) {
                return EmptyView(
                    message:
                        'برای مشاهده سبد خرید ابتدا وارد حساب کاربری خود شوید',
                    callToAction: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true)
                              .push(MaterialPageRoute(
                            builder: (context) => AuthScreen(),
                          ));
                        },
                        child: Text('ورود به حساب کاربری')),
                    image: SvgPicture.asset(
                      'assets/img/auth_required.svg',
                      width: 200,
                    ));
              } else if (state is CartEmpty) {
                return EmptyView(
                    message:
                        'تا کنون هیچ کالایی به سبد خرید خود اضافه نکرده اید',
                    callToAction: null,
                    image: SvgPicture.asset(
                      'assets/img/empty_cart.svg',
                      width: 200,
                    ));
              } else {
                throw Exception('current cart is not valid');
              }
            },
          ),
        )
        // ValueListenableBuilder<AuthInfo?>(
        //   valueListenable: AuthRepository.authChangeNotifier,
        //   builder: (context, state, child) {
        //     bool isAuthenticated = state != null && state.accessToken.isNotEmpty;
        //     return SizedBox(
        //       width: MediaQuery.of(context).size.width,
        //       child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             Text(isAuthenticated
        //                 ? 'خوش آمدید'
        //                 : 'لطفا وارد حساب کاربری خود شوید'),
        //             isAuthenticated
        //                 ? ElevatedButton(
        //                     onPressed: () {
        //                       authRepository.signOut();
        //                     },
        //                     child: Text('خروج از حساب کاربری'),
        //                   )
        //                 : ElevatedButton(
        //                     onPressed: () {
        //                       Navigator.of(context, rootNavigator: true)
        //                           .push(MaterialPageRoute(
        //                         builder: (context) => AuthScreen(),
        //                       ));
        //                     },
        //                     child: Text('ورود'),
        //                   ),
        //             SizedBox(
        //               height: 16,
        //             ),
        //             ElevatedButton(
        //                 onPressed: () async {
        //                   await authRepository.refreshToken();
        //                 },
        //                 child: Text('Refresh Token')),
        //           ]),
        //     );
        //   },
        // ),
        );
  }
}
