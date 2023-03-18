import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_store/common/utils.dart';
import 'package:nike_store/data/product.dart';
import 'package:nike_store/data/repo/product_repository.dart';
import 'package:nike_store/ui/list/bloc/product_list_bloc.dart';
import 'package:nike_store/ui/product/product.dart';
import 'package:nike_store/ui/product/product_list.dart';

class ProductListScreen extends StatefulWidget {
  final int sort;

  const ProductListScreen({super.key, required this.sort});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

enum ViewType { grid, list }

class _ProductListScreenState extends State<ProductListScreen> {
  ProductListBloc? productListBloc;
  ViewType viewType = ViewType.grid;
  @override
  void dispose() {
    productListBloc!.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('کفش های ورزشی'),
      ),
      body: BlocProvider<ProductListBloc>(
        create: (context) {
          productListBloc = ProductListBloc(productRepository)
            ..add(ProductListStarted(widget.sort));
          return productListBloc!;
        },
        child: BlocBuilder<ProductListBloc, ProductListState>(
          builder: (context, state) {
            if (state is ProductListSuccess) {
              final products = state.products;
              return Column(
                children: [
                  Container(
                    height: 56,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            top: BorderSide(
                                color: Theme.of(context).dividerColor)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 20)
                        ]),
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              height: 250,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(0),
                                  color: Colors.white),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 24, bottom: 24),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'انتخاب مرتب سازی',
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: state.sortNames.length,
                                        itemBuilder: (context, index) {
                                          final selectedSortIndex = state.sort;
                                          return InkWell(
                                            onTap: () {
                                              productListBloc!.add(
                                                  ProductListStarted(index));
                                              Navigator.pop(context);
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      16, 8, 16, 8),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    index == selectedSortIndex
                                                        ? CupertinoIcons
                                                            .check_mark_circled_solid
                                                        : CupertinoIcons.circle,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  Text(
                                                    state.sortNames[index],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Row(
                        children: [
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(CupertinoIcons.sort_down)),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('مرتب سازی'),
                                    Text(
                                      ProductSort.names[state.sort],
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    )
                                  ],
                                )
                              ],
                            ),
                          )),
                          Container(
                            width: 1,
                            color: Theme.of(context).dividerColor,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    viewType = viewType == ViewType.grid
                                        ? ViewType.list
                                        : ViewType.grid;
                                  });
                                },
                                icon: viewType == ViewType.grid
                                    ? Icon(CupertinoIcons.square_grid_2x2)
                                    : Icon(CupertinoIcons
                                        .list_dash)),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: viewType == ViewType.grid
                        ? GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, childAspectRatio: 0.65),
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              final product = products[index];
                              return ProductItem(
                                  product: product,
                                  borderRadius: BorderRadius.zero);
                            },
                          )
                        : ListView.builder(
                            itemCount: products.length,
                            physics: defultScrollPhysics,
                            itemBuilder: (context, index) {
                              final product = products[index];
                              return ProductListItem(
                                  product: product,
                                  borderRadius: BorderRadius.circular(12));
                            },
                          ),
                  ),
                ],
              );
            } else {
              return Center(
                child: CupertinoActivityIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
