import 'package:flutter/material.dart';
import '../widgets/pensiones_intro.dart';
import '../widgets/pensiones_card.dart';
// paleta de colores 
import '../../../../core/theme/app_colors.dart';
// funciones globales de funcionalidad go, alerts, modal de confimación 
import '../../../../core/utils/ui_helpers.dart';

class HomePensionesPage extends StatelessWidget {
  const HomePensionesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const PensionesHeader(),
              // const SizedBox(height: 25),
              const PensionesIntro(),
              const SizedBox(height: 30),

              PensionesCard(
                title: "Modalidad 40",
                subtitle: "Aumenta tu pensión hasta 300%.",
                icon: Icons.trending_up,
                highlight: false,
                onTap: () => go(context, '/pensiones/modalidad/40'),
              ),

              const SizedBox(height: 20),

              PensionesCard(
                title: "Modalidad 10",
                subtitle: "Ahorra de forma voluntaria y mejora tu retiro.",
                icon: Icons.savings,
                highlight: false,
                onTap: () {},
              ),

              const SizedBox(height: 20),
              
              // PensionesCard(
              //   title: "Simular mi Pensión",
              //   subtitle:
              //       "Ingresa y simula tu pensión para ver un estimado con Joli",
              //   icon: Icons.calculate,
              //   highlight: true,
              //   onTap: () {},
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
