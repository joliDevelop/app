import 'package:flutter/material.dart';

import '../../data/asesoria_model.dart';
import '../../../../core/theme/app_colors.dart';

class BurbujaBot extends StatelessWidget {
  final String texto;

  const BurbujaBot({
    super.key,
    required this.texto,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Flexible(
            child: Container(
              margin: const EdgeInsets.only(bottom: 6),
              padding: const EdgeInsets.symmetric(
                horizontal: 13,
                vertical: 13,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                  bottomRight: Radius.circular(18),
                  bottomLeft: Radius.circular(4),
                ),
                border: Border.all(color: AppColors.border),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.dark.withOpacity(0.06),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                texto,
                style: const TextStyle(
                  fontSize: 15.5,
                  color: AppColors.dark,
                  height: 1.45,
                ),
              ),
            ),
          ),
          const SizedBox(width: 40),
        ],
      ),
    );
  }
}

class BurbujaUsuario extends StatelessWidget {
  final String texto;

  const BurbujaUsuario({
    super.key,
    required this.texto,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(width: 40),
          Flexible(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 120,
                maxWidth: 230,
              ),
              child: Container(
                margin: const EdgeInsets.only(bottom: 6),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.navy, AppColors.joli],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18),
                    topRight: Radius.circular(18),
                    bottomLeft: Radius.circular(18),
                    bottomRight: Radius.circular(4),
                  ),
                ),
                child: Text(
                  texto,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    height: 1.35,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OpcionesChat extends StatelessWidget {
  final List<PreguntaOpcion> opciones;
  final ValueChanged<PreguntaOpcion> onSeleccion;

  const OpcionesChat({
    super.key,
    required this.opciones,
    required this.onSeleccion,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double maxWidth = constraints.maxWidth;
        final bool unaColumna = maxWidth < 360;
        final int columnas = unaColumna ? 1 : 2;
        final double spacing = 12;
        final double itemWidth =
            (maxWidth - (spacing * (columnas - 1))) / columnas;

        return Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: spacing,
            runSpacing: spacing,
            children: opciones.map((opcion) {
              return SizedBox(
                width: itemWidth,
                child: _ChipOpcion(
                  opcion: opcion,
                  onTap: () => onSeleccion(opcion),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

class _ChipOpcion extends StatelessWidget {
  final PreguntaOpcion opcion;
  final VoidCallback onTap;

  const _ChipOpcion({
    required this.opcion,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        splashColor: AppColors.joli.withOpacity(0.08),
        highlightColor: AppColors.joli.withOpacity(0.04),
        child: Container(
          constraints: const BoxConstraints(
            minHeight: 52,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: AppColors.joli.withOpacity(0.35),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.dark.withOpacity(0.04),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Text(
              opcion.texto,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13.8,
                color: AppColors.navy,
                fontWeight: FontWeight.w600,
                height: 1.2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ContactoCard extends StatelessWidget {
  final VoidCallback onWhatsApp;
  final VoidCallback onTelefono;
  final VoidCallback onCorreo;

  const ContactoCard({
    super.key,
    required this.onWhatsApp,
    required this.onTelefono,
    required this.onCorreo,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 42, right: 16),
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 6),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.border),
            boxShadow: [
              BoxShadow(
                color: AppColors.dark.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Contacta a un asesor Joli',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.dark,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Estamos listos para ayudarte de forma personalizada.',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textMuted,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 14),
              _ContactoBtn(
                label: 'WhatsApp',
                color: AppColors.primary,
                onTap: onWhatsApp,
              ),
              const SizedBox(height: 8),
              _ContactoBtn(
                label: 'Llamar',
                color: AppColors.navy,
                onTap: onTelefono,
              ),
              const SizedBox(height: 8),
              _ContactoBtn(
                label: 'Correo electrónico',
                color: AppColors.joli,
                onTap: onCorreo,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactoBtn extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ContactoBtn({
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 13),
          side: BorderSide(color: color.withOpacity(0.4)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: color.withOpacity(0.06),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14.5,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ),
    );
  }
}

class TypingIndicator extends StatefulWidget {
  const TypingIndicator({super.key});

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animacion;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _animacion = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: AppColors.dark.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: AnimatedBuilder(
          animation: _animacion,
          builder: (_, __) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(3, (index) {
                final opacity = index == 0
                    ? _animacion.value
                    : index == 1
                        ? (_animacion.value * 0.8).clamp(0.2, 1.0)
                        : (1 - _animacion.value + 0.3).clamp(0.2, 1.0);

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: Opacity(
                    opacity: opacity,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.joli,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                );
              }),
            );
          },
        ),
      ),
    );
  }
}