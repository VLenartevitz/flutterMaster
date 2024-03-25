import 'package:flutter/material.dart';

import '../../../commons/app_colors.dart';

class StepsWidget extends StatelessWidget {
  final int indexActive;
  final int size;
  final double height;
  final double width;
  final double widthComponent;
  final double widthActive;

  const StepsWidget({
    this.indexActive = 0,
    this.size = 4,
    this.height = 11,
    this.width = 11,
    this.widthActive = 32,
    this.widthComponent = 130,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widthComponent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(size, (index) {
          return Container(
            height: height,
            width: indexActive == index ? widthActive : width,
            decoration: BoxDecoration(
              color: AppColors.neutral.withOpacity(indexActive == index ? 1 : 0.6),
              borderRadius: BorderRadius.circular(50),
            ),
          );
        }),
      ),
    );
  }
}
