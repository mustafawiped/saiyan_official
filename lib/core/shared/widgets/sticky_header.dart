// Sticky header delegate
import 'package:flutter/material.dart';

class StickyHeaderDelegateWidget extends SliverPersistentHeaderDelegate {
  final Widget child;

  StickyHeaderDelegateWidget({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: child,
    );
  }

  @override
  double get maxExtent => 60.0;
  @override
  double get minExtent => 60.0;
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
