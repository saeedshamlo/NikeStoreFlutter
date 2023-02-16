import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nike_store/data/repo/auth_repository.dart';
import 'package:nike_store/data/repo/cart_repository.dart';
import 'package:nike_store/ui/cart/cart.dart';
import 'package:nike_store/ui/home/home.dart';

const int homeIndex = 0;
const int seearchIndex = 1;
const int cartIndex = 2;

const int profileIndex = 3;

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int selectedTabIndex = homeIndex;
  final List<int> history = [];

  GlobalKey<NavigatorState> _homeKey = GlobalKey();
  GlobalKey<NavigatorState> _cartleKey = GlobalKey();
  GlobalKey<NavigatorState> _searchKey = GlobalKey();
  GlobalKey<NavigatorState> _profileKey = GlobalKey();

  late final map = {
    homeIndex: _homeKey,
    seearchIndex: _searchKey,
    cartIndex: _cartleKey,
    profileIndex: _profileKey,
  };
  Future<bool> _onWiilPop() async {
    final NavigatorState currentTaNavigatorState =
        map[selectedTabIndex]!.currentState!;

    if (currentTaNavigatorState.canPop()) {
      currentTaNavigatorState.pop();
      return false;
    } else if (history.isNotEmpty) {
      setState(() {
        selectedTabIndex = history.last;
        history.removeLast();
      });
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: IndexedStack(
            index: selectedTabIndex,
            children: [
              navigator(_homeKey, homeIndex, const HomeScreen()),
              navigator(
                  _searchKey,
                  seearchIndex,
                  Center(
                    child: Text('Search'),
                  )),
              navigator(_cartleKey, cartIndex, CartScreen()),
              navigator(
                  _profileKey,
                  profileIndex,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Profile'),
                      ElevatedButton(
                          onPressed: () {
                            authRepository.signOut();
                            CartRepository.cartItemCountNotifier.value = 0;
                          },
                          child: Text('Sign Out'))
                    ],
                  )),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                  icon: SvgPicture.asset('assets/icon/home.svg'),
                  label: 'خانه',
                  activeIcon: SvgPicture.asset('assets/icon/home_active.svg')),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset('assets/icon/search.svg'),
                  label: 'جستجو',
                  activeIcon:
                      SvgPicture.asset('assets/icon/search_active.svg')),
              BottomNavigationBarItem(
                  icon: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      SvgPicture.asset('assets/icon/cart.svg'),
                      Positioned(
                        child: ValueListenableBuilder<int>(
                          valueListenable: CartRepository.cartItemCountNotifier,
                          builder: (context, value, child) =>
                              Badge(child:Text(value.toString())),
                        ),
                        right: -10,
                      )
                    ],
                  ),
                  label: 'سبد خرید',
                  activeIcon: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      SvgPicture.asset('assets/icon/cart_active.svg'),
                      Positioned(
                        child: ValueListenableBuilder<int>(
                          valueListenable: CartRepository.cartItemCountNotifier,
                          builder: (context, value, child) =>
                              Badge(child:Text(value.toString())),
                        ),
                        right: -10,
                      )
                    ],
                  )),
          
              BottomNavigationBarItem(
                  icon: SvgPicture.asset('assets/icon/profile.svg'),
                  label: 'پروفایل',
                  activeIcon:
                      SvgPicture.asset('assets/icon/profile_active.svg'))
            ],
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: false,
            showSelectedLabels: false,
            backgroundColor: Colors.white,
          
            elevation: 24,
            selectedItemColor: Theme.of(context).primaryColor,
            unselectedItemColor: Colors.black.withOpacity(0.3),
            currentIndex: this.selectedTabIndex,
            onTap: (selectedIndex) {
              setState(() {
                history.remove(selectedTabIndex);
                history.add(selectedTabIndex);
                this.selectedTabIndex = selectedIndex;
              });
            },
          ),
        ),
        onWillPop: _onWiilPop);
  }

  Widget navigator(GlobalKey key, int index, Widget child) {
    return key.currentState == null && selectedTabIndex != index
        ? Container()
        : Navigator(
            key: key,
            onGenerateRoute: (settings) => MaterialPageRoute(
              builder: (context) =>
                  Offstage(offstage: selectedTabIndex != index, child: child),
            ),
          );
  }

  @override
  void initState() {
    cartRepository.count();
    super.initState();
  }
}
