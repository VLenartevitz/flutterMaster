import 'package:flutter/material.dart';

import '../../commons/app_colors.dart';
import '../../routes/app_routes.dart';

class CardBillWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final DateTime date;
  final String value;
  final String companyLogo;

  const CardBillWidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.date,
    required this.value,
    required this.companyLogo,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => AppRoutes.billDetail.push(),
      child: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 5
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2.0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  child: Image.asset(
                    companyLogo,
                  ),
                ),
                const SizedBox(width: 15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(subTitle),
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "${date.day} ${date.month} ${date.year}",
                  style: const TextStyle(fontSize: 12),
                ),
                Text(
                  "R\$ $value",
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
                Container(
                  height: 6,
                  width: 20,
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
