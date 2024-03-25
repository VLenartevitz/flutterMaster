import 'package:flutter/material.dart';

import '../../models/genders_model.dart';
import '../../commons/app_icons.dart';
import '../../commons/app_images.dart';
import '../../commons/app_value_listenable_builder.dart';
import '../../commons/font_family.dart';
import '../../commons/app_colors.dart';
import '../../commons/formatters/date_input_formatter.dart';
import '../../controllers/register_controller.dart';
import '../../routes/app_routes.dart';
import '../../services/di.dart';
import '../../widgets/app_input.dart';
import '../screen.dart';
import 'widgets/app_btn_cancel.dart';
import 'widgets/modal_terms.dart';
import '../../widgets/app_btn.dart';
import 'widgets/steps_widget.dart';

//Tela para escolher o nome e o genero
//O genero é salvo por index
//Ao clicar no btn Continuar salva os valores chamando a controller depois de uma validação

class RegisterPersonalIdentification extends StatefulWidget {
  const RegisterPersonalIdentification({super.key});

  @override
  State<RegisterPersonalIdentification> createState() =>
      _RegisterPersonalIdentification();
}

class _RegisterPersonalIdentification extends State<RegisterPersonalIdentification> {
  final _formKey = GlobalKey<FormState>();
  final _nameInput = TextEditingController();
  final _controller = DI.resolve(RegisterController());

  List<GendersModel> genders = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  List<String> dropdownItems = ['Homem Cis','Homem Trans','Mulher Cis', 'Mulher Trans', 'Não Binário'];

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Screen(
      formKey: _formKey,
      isLoading: _controller.isLoading,
      backgroundColor: AppColors.gray,
      height: MediaQuery.of(context).size.height / 1.1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const SizedBox(height: 15),
              const StepsWidget(indexActive: 1),
              const SizedBox(height: 30),
              Image.asset(AppImages.logo),
              const SizedBox(height: 50),
              const Text(
                "Perfeito!",
                style: TextStyle(
                  color: AppColors.neutral,
                  fontFamily: FontFamily.appFont,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 30),

              const Text(
                "Como quer que a gente te chame?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.neutral,
                  fontFamily: FontFamily.appFont,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20),
              AppInput(
                key: const Key("input.name"),
                fillColor: AppColors.light,
                controller: _nameInput,
                prefixIcon: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: AppIcons.user,
                ),
                autoFocus: true,
                inputType: TextInputType.name,
                hint: "Nome",
                msgValidator: "Informe o seu nome",
              ),
              const SizedBox(height: 20),

              const Text(
                "E que gênero você se identifica?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.neutral,
                  fontFamily: FontFamily.appFont,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  fillColor: AppColors.white,
                  filled: true,
                  prefixIcon: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                ),
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down_circle),
                hint: const Text('Selecione'),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppColors.inputHint,
                ),
                value: selectedValue,
                items: genders.map((GendersModel gender) {
                  return DropdownMenuItem<String>(
                    value: gender.id,
                    child: Text(gender.name),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedValue = newValue;
                  });
                },
              ),
              const SizedBox(height: 20),
              AppValueListenableBuilder(
                valueListenables: [_nameInput],
                builder: (_) => AppBtn(
                  textColor: AppColors.white,
                  text: 'Continuar',
                  bgColor: AppColors.brandBlue,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                    _controller.form.value['name'] = _nameInput.text;
                    _controller.form.value['gender'] = selectedValue!;

                    AppRoutes.registerPhoneNumber.push();
                    }
                  }
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Não se preocupe, você pode alterar estas informações depois!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.neutral,
                  fontFamily: FontFamily.appFont,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const AppBtnCancel(),

        ],

      ),

    );
  }

  void fetchData() async {
    List<GendersModel> fetchedGenders = await _controller.listGenders();
    setState(() {
      genders = fetchedGenders;
    });
  }
}
