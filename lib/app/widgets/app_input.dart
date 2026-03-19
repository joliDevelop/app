//  # C Y HECTOR
// Imput global para mantener consistencia en los campos/formularios de texto de la app 

// Este widget de un imput personalizado que se puede reutilizar en toda la aplicación. 
// Permite configurar el controlador, el texto de sugerencia, el ícono, si el texto debe ocultarse 
// (para contraseñas), el tipo de teclado, los formateadores de entrada, si hay un error 
// y una función para manejar cambios en el texto. El diseño incluye bordes redondeados 
// y colores que cambian según si hay un error o no.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';

class AppInput extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final bool obscure;
  final TextInputType type;
  final List<TextInputFormatter>? formatters;
  final bool hasError;
  final Function(String)? onChanged;

  const AppInput({
    super.key,
    required this.controller,
    required this.hint,
    required this.icon,
    this.obscure = false,
    this.type = TextInputType.text,
    this.formatters,
    this.hasError = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = hasError ? Colors.red : AppColors.border;
    final iconColor = hasError ? Colors.red : AppColors.navy;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SizedBox(
        width: double.infinity, 
        child: TextField(
          controller: controller,
          obscureText: obscure,
          keyboardType: type,
          inputFormatters: formatters,
          textCapitalization: type == TextInputType.emailAddress
              ? TextCapitalization.none
              : TextCapitalization.words,
          onChanged: onChanged,
          style: const TextStyle(fontSize: 18, color: Colors.black87),
          decoration: InputDecoration(
            hintText: hint,

            hintStyle: TextStyle(
              color: const Color.fromARGB(255, 134, 134, 134),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),

            filled: true,
            fillColor: Colors.grey.shade50, 

            prefixIcon: Icon(icon, color: iconColor),

            contentPadding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 18,
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18), 
              borderSide: BorderSide(color: borderColor, width: 1),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(
                color: hasError ? Colors.red : AppColors.navy,
                width: 1.5, 
              ),
            ),

            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }
}
