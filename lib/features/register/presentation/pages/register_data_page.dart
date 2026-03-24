// Paso 1

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/ui_helpers.dart';
import '../../../../core/widgets/dinamicbar.dart';
import '../../../../core/utils/formatters_imputs.dart';
import '../../../../core/widgets/app_input.dart';
// spinner
import '../../../../core/services/loading_service.dart';
// provider propio 
import '../../presentation/providers/register_provider.dart';

class RegisterDataPage extends StatefulWidget {
  const RegisterDataPage({super.key});

  @override
  State<RegisterDataPage> createState() => _RegisterDataPageState();
}

class _RegisterDataPageState extends State<RegisterDataPage> {
  Future<void> _register() async {
    LoadingService.show();

    try {
      final provider = context.read<RegisterProvider>();

      final user = await provider.register();

      LoadingService.hide();

      if (!mounted) return;

      if (user == null) {
        showErrorSnackBar(context, "Corrige los campos");
        return;
      }

      go(context, '/registro/select/verification', extra: user.toJson());
    } catch (e) {
      LoadingService.hide();

      final errorMessage = e.toString().replaceFirst("Exception: ", "");
      showErrorSnackBar(context, errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RegisterProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: const AppBarGlobal(title: "Crear cuenta"),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Center(
                child: Column(
                  children: const [
                    Image(
                      image: AssetImage('assets/home/joli_1.png'),
                      height: 45,
                    ),

                    SizedBox(height: 6),

                    Text(
                      "Ingresa tus datos para crear tu cuenta",
                      style: TextStyle(fontSize: 13, color: Colors.black54),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              AppInput(
                controller: provider.nombre,
                hint: "Nombre",
                icon: Icons.person,
                hasError: provider.nombreError,
                formatters: [CapitalizeFirstLetterFormatter()],
                onChanged: (value) {
                  if (value.isNotEmpty && provider.nombreError) {
                    setState(() => provider.nombreError = false);
                  }
                },
              ),

              AppInput(
                controller: provider.apellidoP,
                hint: "Apellido paterno",
                icon: Icons.badge,
                hasError: provider.apellidoPError,
                formatters: [CapitalizeFirstLetterFormatter()],
                onChanged: (value) {
                  if (value.isNotEmpty && provider.apellidoPError) {
                    setState(() => provider.apellidoPError = false);
                  }
                },
              ),

              AppInput(
                controller: provider.apellidoM,
                hint: "Apellido materno",
                icon: Icons.badge_outlined,
                hasError: provider.apellidoMError,
                formatters: [CapitalizeFirstLetterFormatter()],
                onChanged: (value) {
                  if (value.isNotEmpty && provider.apellidoMError) {
                    setState(() => provider.apellidoMError = false);
                  }
                },
              ),

              AppInput(
                controller: provider.edad,
                hint: "Edad",
                icon: Icons.cake,
                hasError: provider.edadError,
                type: TextInputType.number,
                onChanged: (value) {
                  final edad = int.tryParse(value);

                  if (edad == null) {
                    setState(() => provider.edadError = true);
                    return;
                  }

                  if (edad < 18 || edad > 100) {
                    setState(() => provider.edadError = true);
                  } else {
                    if (provider.edadError) {
                      setState(() => provider.edadError = false);
                    }
                  }
                },
              ),

              AppInput(
                controller: provider.telefono,
                hint: "Teléfono",
                icon: Icons.phone,
                hasError: provider.telefonoError,
                type: TextInputType.number,
                formatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                onChanged: (value) {
                  if (value.length == 10) {
                    setState(() => provider.telefonoError = false);
                  } else {
                    setState(() => provider.telefonoError = true);
                  }
                },
              ),

              AppInput(
                controller: provider.email,
                hint: "Correo electrónico",
                icon: Icons.email,
                hasError: provider.emailError,
                type: TextInputType.emailAddress,
                onChanged: (value) {
                  if (value.isNotEmpty && provider.emailError) {
                    setState(() => provider.emailError = false);
                  }
                },
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.joli,
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        "Continuar",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "¿Ya tienes cuenta? ",
                    style: TextStyle(color: Colors.black54, fontSize: 17),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Iniciar sesión",
                      style: TextStyle(
                        color: AppColors.joli,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 58),
            ],
          ),
        ),
      ),
    );
  }
}
