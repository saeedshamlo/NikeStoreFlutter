import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nike_store/common/utils.dart';
import 'package:nike_store/data/repo/product_repository.dart';
import 'package:nike_store/theme.dart';
import 'package:nike_store/ui/product/product_list.dart';
import 'package:nike_store/ui/search/bloc/search_bloc.dart';
import 'package:nike_store/ui/search/bloc/search_state.dart';
import 'package:nike_store/ui/widget/empty_state.dart';
import 'package:rive/rive.dart';

class SerachScreen extends StatefulWidget {
  @override
  State<SerachScreen> createState() => _SerachScreenState();
}

class _SerachScreenState extends State<SerachScreen> {
  SearchBloc? searchBloc;
  TextEditingController searchController = TextEditingController();
  @override
  void dispose() {
    searchBloc!.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text("جستجو"),
      ),
      body: ListView.builder(
        physics: defultScrollPhysics,
        padding: EdgeInsets.all(16),
        itemCount: 2,
        itemBuilder: (context, index) {
          switch (index) {
            case 0:
              return Container(
                height: 56,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(16)),
                child: TextField(
                  controller: searchController,
                  onChanged: (value) {
                    searchBloc!.add(SearchListStarted(value));
                  },
                  style: Theme.of(context).textTheme.headline6,
                  decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      prefixIcon: Icon(
                        CupertinoIcons.search_circle_fill,
                        color: Theme.of(context).disabledColor,
                      ),
                      suffixIcon: IconButton(
                          onPressed: () {
                            searchController.clear();
                            searchBloc!
                                .add(SearchListStarted(searchController.text));
                          },
                          icon: Icon(CupertinoIcons.clear)),
                      fillColor: LightThemeColors.primatyColor,
                      enabledBorder: InputBorder.none,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16)),
                      label: Text('جستجو در نایک استور...')),
                ),
              );
            case 1:
              return SizedBox(
                height: MediaQuery.of(context).size.height - 150,
                child: BlocProvider<SearchBloc>(
                  create: (context) {
                    searchBloc = SearchBloc(productRepository)
                      ..add(SearchListStarted(searchController.text));
                    return searchBloc!;
                  },
                  child: BlocBuilder<SearchBloc, SearchState>(
                    builder: (context, state) {
                      if (state is SearchLoading) {
                        return Expanded(
                          flex: 2,
                          child: const Center(
                              child: SizedBox(
                                  width: 64,
                                  height: 64,
                                  child: RiveAnimation.asset(
                                      'assets/riv/loading.riv'))),
                        );
                      } else if (state is SearchSuccess) {
                        final products = state.products;
                        if (state.products.isNotEmpty) {
                          return Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: products.length,
                              physics: defultScrollPhysics,
                              itemBuilder: (context, index) {
                                final product = products[index].id;

                                return ProductListItem(
                                    product: products[index],
                                    borderRadius: BorderRadius.circular(16));
                              },
                            ),
                          );
                        } else {
                          return SizedBox(
                              height: MediaQuery.of(context).size.height,
                              child: EmptyView(
                                  message: 'کالایی یافت نشد',
                                  image: Image.asset(
                                    'assets/img/searchnot.jpg',
                                  )));
                        }
                      } else if (state is SearchError) {
                        return Expanded(
                          child: Center(
                            child: Text(state.exception.message),
                          ),
                        );
                      } else {
                        return Center(
                          child: Text(''),
                        );
                      }
                    },
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}
