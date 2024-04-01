import 'package:flutter/material.dart';

import 'shimmer_effect_ui.dart';

class MyShimmerGridView extends StatelessWidget {
  final double? height;
  final int? rowCount;
  final int? itemsCount;
  final bool? isSliver;

  const MyShimmerGridView({
    Key? key,
    this.height,
    this.rowCount,
    this.itemsCount,
    this.isSliver,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isSliver ?? false) {
      return SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: height,
          crossAxisCount: rowCount ?? 2,

          /// child count in a row depends on the max width it can get
          childAspectRatio: 1,
          mainAxisSpacing: 5.0,
          crossAxisSpacing: 5.0,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) => Padding(
            padding: const EdgeInsets.all(2.0),
            child: MyShimmerEffectUI.rectangular(height: height ?? 200),
          ),
          childCount: itemsCount ?? 25,
        ),
      );
    }
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: rowCount ?? 2),
      itemCount: itemsCount ?? 25,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(2.0),
        child: MyShimmerEffectUI.rectangular(height: height ?? 200),
      ),
    );
  }
}
