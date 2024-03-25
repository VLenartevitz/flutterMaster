import 'package:flutter/material.dart';

import '../../../commons/app_colors.dart';

class Avatar extends StatelessWidget {
  final double height;
  final double width;
  final bool editBtn;

  const Avatar({this.height = 90, this.width = 90, this.editBtn = false, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          CircleAvatar(
            child: Icon(
              Icons.manage_accounts_outlined,
              color: Colors.white,
              size: height / 2,
            ),
          ),
          Visibility(
            visible: editBtn,
            child: Positioned(
              bottom: -20,
              right: -5,
              child: RawMaterialButton(
                onPressed: () {},
                elevation: 1.0,
                fillColor: AppColors.white,
                shape: CircleBorder(
                  side: BorderSide(color: AppColors.primary)
                ),
                child: Icon(
                  Icons.edit,
                  color: AppColors.primary,
                  size: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
