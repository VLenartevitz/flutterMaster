import 'package:flutter/material.dart';

import '../../commons/app_colors.dart';
import '../../controllers/dashboard_controller.dart';
import '../../routes/app_routes.dart';
import '../../services/di.dart';
import '../screen.dart';

class BillDetailScreen extends StatefulWidget {
  const BillDetailScreen({super.key});

  @override
  State<BillDetailScreen> createState() => _BillDetailScreenState();
}

class _BillDetailScreenState extends State<BillDetailScreen> {
  final _controller = DI.resolve(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Screen(
      isLoading: _controller.isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppRoutes.billDetail.name),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 30),
              const Row(
                children: [
                  Text("Tipo de despesa: "),
                  Text("Fixa"),
                ],
              ),
              const SizedBox(height: 10),
              const Row(
                children: [
                  Text("Tipo de pagamento: "),
                  Text("Meus Agendamentos"),
                ],
              ),
              const SizedBox(height: 20),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Nome do fornecedor:"),
                  Text("..."),
                ],
              ),
              const SizedBox(height: 20),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Valor:"),
                  Text("..."),
                ],
              ),
              const SizedBox(height: 20),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Forma selecionada para esse pagamento:"),
                  Text("..."),
                ],
              ),
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Data de vencimento:"),
                      Text("13/10/2023"),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Data de pagamento:"),
                      Text("13/10/2023"),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 40),
              InkWell(
                hoverColor: Colors.transparent,
                onTap: () => {},
                child: Container(
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.attach_file, size: 35),
                      Text(
                        "Visualizar nota fiscal e boleto",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.warning,
                  minimumSize: const Size.fromHeight(65),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                child: Text(
                  "Cancelar agendamento",
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
