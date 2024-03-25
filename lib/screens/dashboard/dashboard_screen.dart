import 'package:billx/widgets/app_list_item.dart';
import 'package:flutter/material.dart';

import '../../commons/app_colors.dart';
import '../../commons/app_images.dart';
import '../../controllers/dashboard_controller.dart';
import '../../services/di.dart';
import '../../utils/sizes.dart';
import '../screen.dart';
import 'card_bill_widget.dart';

/*
* @deprecated
*
* it was used before BillsScreen
* */
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _controller = DI.resolve(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Screen(
      isLoading: _controller.isLoading,
      child: SafeArea(
        child: Container(
          // color: Colors.white24,
          height: AppSizes.height,
          child: Stack(
            children: [
              Container(
                height: 250,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  // borderRadius: BorderRadius.only(
                  //   bottomRight: Radius.circular(50),
                  //   bottomLeft: Radius.circular(50),
                  // )
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Olá, ",
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          _controller.userModel.firstName,
                          style: TextStyle(
                            fontSize: 20,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Text(
                            "R\$ ",
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Text(
                          "4.687,00",
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 40,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Saldo geral",
                      style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down_sharp,
                      size: 30,
                      color: AppColors.white,
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 180,
                // right: 0.0,
                // left: 0.0,
                bottom: 0.0,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 7,
                        padding: const EdgeInsets.symmetric(horizontal: 35),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5.0,
                              // spreadRadius: 2.0,
                            ),
                          ],
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "05",
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 30,
                                  ),
                                ),
                                Text("Pagos"),
                              ],
                            ),
                            VerticalDivider(
                              color: Colors.grey,
                              thickness: 1,
                              indent: 20,
                              endIndent: 20,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "12",
                                  style: TextStyle(
                                    color: Colors.orangeAccent,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 30,
                                  ),
                                ),
                                Text("A vencer"),
                              ],
                            ),
                            VerticalDivider(
                              color: Colors.grey,
                              thickness: 1,
                              indent: 20,
                              endIndent: 20,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "02",
                                  style: TextStyle(
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 30,
                                  ),
                                ),
                                Text("Vencidos"),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),
                      AppListItem(
                        title: 'Claro',
                        value: '100,00',
                        description: "email",
                        dueDate: DateTime(2024, 2, 19),
                        icon: '100,00',
                        status: 'NP',
                        onPressed: () {
                          print('Card clicado!');
                        },
                      ),
                      AppListItem(
                        title: 'Claro',
                        value: '100,00',
                        description: "email",
                        dueDate: DateTime(2024, 2, 19),
                        icon: '100,00',
                        status: 'NP',
                        onPressed: () {
                          print('Card clicado!');
                        },
                      ),
                      CardBillWidget(
                        title: 'Volksvagem Brasil',
                        companyLogo: AppImages.logo,
                        subTitle: 'Novo boleto',
                        date: DateTime.now(),
                        value: '1223,64',
                      ),
                      CardBillWidget(
                        title: 'Volksvagem Brasil',
                        companyLogo: AppImages.logo,
                        subTitle: 'Novo boleto',
                        date: DateTime.now(),
                        value: '1223,64',
                      ),
                      const SizedBox(height: 25),
                    ],
                  ),
                ), //CircularAvatar
              ),
            ],
          ),
        ),
      ),
    );
  }
}
