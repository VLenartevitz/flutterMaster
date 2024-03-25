import 'package:flutter/material.dart';

import '../../../controllers/auth_controller.dart';
import '../../../models/user_model.dart';
import '../../../routes/app_routes.dart';
import '../../../extensions/datetime_extensions.dart';
import '../../../extensions/phone_number_extensions.dart';
import '../../../services/di.dart';
import '../../../utils/sizes.dart';
import 'avatar.dart';

class MyDataScreen extends StatefulWidget {
  const MyDataScreen({super.key});

  @override
  State<MyDataScreen> createState() => _MyDataScreenState();
}

class _MyDataScreenState extends State<MyDataScreen> {
  final controller = DI.resolve(AuthController());
  late final UserModel user;

  @override
  void initState() {
    super.initState();

    user = controller.authModel.user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppRoutes.profileMyData.name),
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.infinity,
        height: AppSizes.height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Avatar(editBtn: true),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Nome"),
                          Text(
                            user.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              height: 1.2,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 60),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      onTap: () {},
                      title: const Text("BillX ID"),
                      subtitle: Text(
                        user.billxId,
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          height: 1.2,
                          fontSize: 20,
                        ),
                      ),
                      visualDensity: const VisualDensity(vertical: 3),
                      trailing: const Icon(Icons.help_outline),
                    ),
                    const Divider(height: 0),
                    ListTile(
                      onTap: () {},
                      title: const Text("CPF/CNPJ"),
                      subtitle: Text(
                        user.cpf,
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          height: 1.2,
                          fontSize: 20,
                        ),
                      ),
                      visualDensity: const VisualDensity(vertical: 3),
                    ),
                    const Divider(height: 0),
                    ListTile(
                      onTap: () {},
                      title: const Text("Data de nascimento"),
                      subtitle: user.birthday == null
                          ? const SizedBox.shrink()
                          : Text(
                              user.birthday!.format('dd/M/yyyy'),
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                height: 1.2,
                                fontSize: 20,
                              ),
                            ),
                      visualDensity: const VisualDensity(vertical: 3),
                    ),
                    const Divider(height: 0),
                    ListTile(
                      onTap: null,
                      title: const Text("Celular"),
                      subtitle: Text(
                        user.phoneNumber.formatted(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          height: 1.2,
                          fontSize: 20,
                        ),
                      ),
                      visualDensity: const VisualDensity(vertical: 3),
                    ),
                    const Divider(height: 0),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
