import 'package:flutter/material.dart';

import 'shimmer_effect_ui.dart';

class MyShimmerListView extends StatelessWidget {
  final double? height;
  final int? itemsCount;
  final bool? isSliver;

  const MyShimmerListView({
    Key? key,
    this.height,
    this.itemsCount,
    this.isSliver,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isSliver ?? false) {
      return SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: height,
          crossAxisCount: 1,

          /// child count in a row depends on the max width it can get
          childAspectRatio: 1,
          mainAxisSpacing: 5.0,
          crossAxisSpacing: 5.0,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) => Padding(
            padding: const EdgeInsets.all(4.0),
            child: MyShimmerEffectUI.rectangular(
              height: height ?? 200,
            ),
          ),
          childCount: itemsCount ?? 25,
        ),
      );
    }
    return ListView.builder(
      itemCount: itemsCount ?? 25,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(4.0),
        child: MyShimmerEffectUI.rectangular(height: height ?? 200),
      ),
    );
  }
}
