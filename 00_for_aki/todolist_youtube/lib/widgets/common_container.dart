import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todolist_youtube/utils/extensions.dart';
import 'package:todolist_youtube/widgets/widgets.dart';

class CommonContainer extends StatelessWidget {
  const CommonContainer({super.key, this.child, this.height});
  final Widget? child;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final deviceSize = context.deviceSize;

    return Container(
        width: deviceSize.width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: context.colorScheme.primaryContainer,
        ),
        child: child);
  }
}
