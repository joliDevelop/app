import 'package:flutter/material.dart';

class PensionesHeader extends StatelessWidget {
  const PensionesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "Tu retiro no es suerte. Es estrategia.",
          style: TextStyle(
            fontSize: 18,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ),
      ],
    );
  }
}