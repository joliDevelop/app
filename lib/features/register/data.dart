import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../app/theme/app_colors.dart';
import '../../app/services/auth_service.dart';
import '../../app/utils/ui_helpers.dart';
import '../../app/widgets/dinamicbar.dart';
import '../../app/utils/formatters_imputs.dart';
import '../../app/widgets/app_input.dart';
import '../../app/services/general_service.dart';

class RegisterDataPage extends StatefulWidget {
  const RegisterDataPage({super.key});

  @override
  State<RegisterDataPage> createState() => _RegisterDataPageState();
}

class _RegisterDataPageState extends State<RegisterDataPage> {
  final _nombre = TextEditingController();
  final _apellidoP = TextEditingController();
  final _apellidoM = TextEditingController();
  final _edad = TextEditingController();
  final _email = TextEditingController();
  final _telefono = TextEditingController();

  bool _nombreError = false;
  bool _apellidoPError = false;
  bool _apellidoMError = false;
  bool _edadError = false;
  bool _telefonoError = false;
  bool _emailError = false;

  bool _loading = false;

  Future<void> _register() async {
    setState(() {
      _nombreError = false;
      _apellidoPError = false;
      _apellidoMError = false;
      _edadError = false;
      _telefonoError = false;
      _emailError = false;
    });

    if (_nombre.text.isEmpty) {
      setState(() => _nombreError = true);
      showErrorSnackBar(context, "Ingresa tu nombre");
      return;
    }

    if (_apellidoP.text.isEmpty) {
      setState(() => _apellidoPError = true);
      showErrorSnackBar(context, "Ingresa tu apellido paterno");
      return;
    }

    if (_apellidoM.text.isEmpty) {
      setState(() => _apellidoMError = true);
      showErrorSnackBar(context, "Ingresa tu apellido materno");
      return;
    }

    if (_edad.text.isEmpty) {
      setState(() => _edadError = true);
      showErrorSnackBar(context, "Ingresa tu edad");
      return;
    }

    if (_telefono.text.isEmpty) {
      setState(() => _telefonoError = true);
      showErrorSnackBar(context, "Ingresa tu teléfono");
      return;
    }

    if (_email.text.isEmpty) {
      setState(() => _emailError = true);
      showErrorSnackBar(context, "Ingresa tu email");
      return;
    }

    setState(() => _loading = true);

    LoadingService.show();

    try {
      await AuthService.preregister(
        nombre: _nombre.text,
        apellidoP: _apellidoP.text,
        apellidoM: _apellidoM.text,
        edad: int.parse(_edad.text),
        lada: "+52",
        telefono: _telefono.text,
        email: _email.text,
      );

      if (!mounted) return;

      // showSuccessSnackBar(context, "Verivica tu identidad para continuar");

      LoadingService.hide();
      go(
        context,
        '/registro/select/verification',
        extra: {
          "nombre": _nombre.text,
          "apellidoP": _apellidoP.text,
          "apellidoM": _apellidoM.text,
          "edad": _edad.text,
          "telefono": _telefono.text,
          "email": _email.text,
        },
      );
    } catch (e) {
      LoadingService.hide();
      if (!mounted) return;
      final errorMessage = e.toString().replaceFirst("Exception: ", "");
      showErrorSnackBar(context, errorMessage);
    } finally {
      if (!mounted) return;
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                controller: _nombre,
                hint: "Nombre",
                icon: Icons.person,
                hasError: _nombreError,
                formatters: [CapitalizeFirstLetterFormatter()],
                onChanged: (value) {
                  if (value.isNotEmpty && _nombreError) {
                    setState(() => _nombreError = false);
                  }
                },
              ),

              AppInput(
                controller: _apellidoP,
                hint: "Apellido paterno",
                icon: Icons.badge,
                hasError: _apellidoPError,
                formatters: [CapitalizeFirstLetterFormatter()],
                onChanged: (value) {
                  if (value.isNotEmpty && _apellidoPError) {
                    setState(() => _apellidoPError = false);
                  }
                },
              ),

              AppInput(
                controller: _apellidoM,
                hint: "Apellido materno",
                icon: Icons.badge_outlined,
                hasError: _apellidoMError,
                formatters: [CapitalizeFirstLetterFormatter()],
                onChanged: (value) {
                  if (value.isNotEmpty && _apellidoMError) {
                    setState(() => _apellidoMError = false);
                  }
                },
              ),

              AppInput(
                controller: _edad,
                hint: "Edad",
                icon: Icons.cake,
                hasError: _edadError,
                type: TextInputType.number,
                onChanged: (value) {
                  final edad = int.tryParse(value);

                  if (edad == null) {
                    setState(() => _edadError = true);
                    return;
                  }

                  if (edad < 18 || edad > 100) {
                    setState(() => _edadError = true);
                  } else {
                    if (_edadError) {
                      setState(() => _edadError = false);
                    }
                  }
                },
              ),

              AppInput(
                controller: _telefono,
                hint: "Teléfono",
                icon: Icons.phone,
                hasError: _telefonoError,
                type: TextInputType.number,
                formatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                onChanged: (value) {
                  if (value.length == 10) {
                    setState(() => _telefonoError = false);
                  } else {
                    setState(() => _telefonoError = true);
                  }
                },
              ),

              AppInput(
                controller: _email,
                hint: "Correo electrónico",
                icon: Icons.email,
                hasError: _emailError,
                type: TextInputType.emailAddress,
                onChanged: (value) {
                  if (value.isNotEmpty && _emailError) {
                    setState(() => _emailError = false);
                  }
                },
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _loading ? null : _register,
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
