import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_store/data/auth_info.dart';
import 'package:nike_store/data/repo/auth_repository.dart';
import 'package:nike_store/data/repo/cart_repository.dart';
import 'package:nike_store/ui/auth/auth.dart';
import 'package:nike_store/ui/cart/bloc/cart_bloc.dart';
import 'package:nike_store/ui/widget/image.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('سبد خرید'),
        ),
        body: BlocProvider<CartBloc>(
          create: (context) {
            final bloc = CartBloc(cartRepository);
            bloc.add(CartStarted());
            return bloc;
          },
          child: BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is CartError) {
                return Center(
                  child: Text(state.appException.message!),
                );
              } else if (state is CartSuccess) {
                return ListView.builder(
                  itemCount: state.cartResponse.cartItems.length,
                  itemBuilder: (context, index) {
                    final data = state.cartResponse.cartItems[index];
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10)
                        ],
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: ImageLoadingService(
                                    imageUrl: data.product.image,
                                    radius: BorderRadius.circular(4),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
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
