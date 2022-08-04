import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:nike_store/data/comment.dart';
import 'package:nike_store/data/repo/commnet_repository.dart';
import 'package:nike_store/ui/home/home.dart';
import 'package:nike_store/ui/product/commnet/bloc/commnet_list_bloc.dart';
import 'package:nike_store/ui/widget/error.dart';

class CommentList extends StatelessWidget {
  final int productId;

  const CommentList({super.key, required this.productId});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final CommnetListBloc bloc = CommnetListBloc(
            commnetRepository: commnetRepository, productId: productId);
        bloc.add(CommentListStarted());
        return bloc;
      },
      child: BlocBuilder<CommnetListBloc, CommnetListState>(
        builder: (context, state) {
          if (state is CommnetListSuccess) {
            return SliverList(
                delegate: SliverChildBuilderDelegate(
              childCount: 3,
              (context, index) {
                return CommentItem(data: state.commnets[index]);
              },
            ));
          } else if (state is CommnetListLoading) {
            return const SliverToBoxAdapter(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is CommentListError) {
            return SliverToBoxAdapter(
                child: AppErrorWidget(
                    appException: state.exception,
                    onTryAgainClick: () {
                      BlocProvider.of<CommnetListBloc>(context)
                          .add(CommentListStarted());
                    }));
          }else{
            throw Exception('state is not supported');
          }
        },
      ),
    );
  }
}

class CommentItem extends StatelessWidget {
  final CommnetEntiry data;
  const CommentItem({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: themeData.dividerColor ,width: 0.5,),
        borderRadius: BorderRadius.circular(0)
      ),
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.title),
                  SizedBox(
                    height: 4,
                  ),
                  Text(data.email,style: themeData.textTheme.caption,)
                ],
              ),
              Text(data.date,style: themeData.textTheme.caption,)
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Text(data.content),
        ],
      ),
    );
  }
}
