import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Modelo simple para beneficios
// ─────────────────────────────────────────────────────────────────────────────
class BeneficioItem {
  final String texto;

  const BeneficioItem({required this.texto});
}

// ─────────────────────────────────────────────────────────────────────────────
// ProductoCard
// ─────────────────────────────────────────────────────────────────────────────
class ProductoCard extends StatelessWidget {
  final IconData icono;
  final String etiqueta;
  final String titulo;
  final String subtitulo;
  final String descripcion;
  final List<BeneficioItem> beneficios;
  final String nota;
  final Color colorEtiqueta;
  final VoidCallback onTap;
  final String botonTexto;
  final bool expanded;
  final VoidCallback onToggle;

  const ProductoCard({
    super.key,
    required this.icono,
    required this.etiqueta,
    required this.titulo,
    required this.subtitulo,
    required this.descripcion,
    required this.beneficios,
    required this.nota,
    required this.colorEtiqueta,
    required this.onTap,
    required this.botonTexto,
    required this.expanded,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final isMobile = sw < 600;
    final isSmall = sw < 380;

    final borderRadius = isMobile ? 20.0 : 22.0;
    final pad = isMobile ? 16.0 : 18.0;
    final iconBox = isMobile ? 48.0 : 54.0;
    final iconSize = isMobile ? 24.0 : 26.0;

    final tagFont = isSmall ? 11.5 : isMobile ? 12.0 : 12.5;
    final titleFont = isSmall ? 18.5 : isMobile ? 20.0 : 22.0;
    final subtitleFont = isSmall ? 14.0 : isMobile ? 14.5 : 15.0;
    final descFont = isSmall ? 15.0 : isMobile ? 15.5 : 16.0;
    final btnHeight = isMobile ? 50.0 : 52.0;
    final btnFont = isSmall ? 15.5 : isMobile ? 16.0 : 16.5;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: expanded
              ? colorEtiqueta.withOpacity(0.28)
              : const Color(0xFFE6EBF1),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(expanded ? 0.05 : 0.025),
            blurRadius: expanded ? 14 : 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          InkWell(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(borderRadius),
            ),
            onTap: onToggle,
            child: Padding(
              padding: EdgeInsets.fromLTRB(pad, pad, pad, 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: iconBox,
                    height: iconBox,
                    decoration: BoxDecoration(
                      color: colorEtiqueta.withOpacity(0.10),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      icono,
                      color: colorEtiqueta,
                      size: iconSize,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: colorEtiqueta.withOpacity(0.10),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Text(
                            etiqueta,
                            style: TextStyle(
                              fontSize: tagFont,
                              fontWeight: FontWeight.w700,
                              color: colorEtiqueta,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          titulo,
                          style: TextStyle(
                            fontSize: titleFont,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF1F2A44),
                            height: 1.15,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          subtitulo,
                          style: TextStyle(
                            fontSize: subtitleFont,
                            fontWeight: FontWeight.w600,
                            color: colorEtiqueta,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          descripcion,
                          style: TextStyle(
                            fontSize: descFont,
                            color: const Color(0xFF4A5568),
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 6),
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: AnimatedRotation(
                      turns: expanded ? 0.5 : 0.0,
                      duration: const Duration(milliseconds: 220),
                      curve: Curves.easeInOut,
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: colorEtiqueta,
                        size: 28,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // CIERRE/APERTURA NATURAL
          ClipRect(
            child: AnimatedSize(
              duration: const Duration(milliseconds: 260),
              curve: Curves.easeInOutCubic,
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: expanded
                    ? const BoxConstraints()
                    : const BoxConstraints(maxHeight: 0),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(pad, 0, pad, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Divider(
                        height: 18,
                        thickness: 1,
                        color: Color(0xFFE7EBF0),
                      ),
                      Text(
                        "Beneficios principales",
                        style: TextStyle(
                          fontSize: isMobile ? 16.5 : 17.0,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1F2A44),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ...beneficios.map(
                        (b) => _BenefRowCompact(
                          texto: b.texto,
                          color: colorEtiqueta,
                          fontSize: isSmall ? 14.5 : isMobile ? 15.0 : 15.5,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: colorEtiqueta.withOpacity(0.06),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.lightbulb_outline,
                              color: colorEtiqueta,
                              size: isMobile ? 18 : 19,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                nota,
                                softWrap: true,
                                overflow: TextOverflow.visible,
                                style: TextStyle(
                                  fontSize: isSmall
                                      ? 14.5
                                      : isMobile
                                          ? 15.0
                                          : 15.5,
                                  color: const Color(0xFF374151),
                                  height: 1.45,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(pad, 0, pad, pad),
            child: SizedBox(
              width: double.infinity,
              height: btnHeight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorEtiqueta,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: onTap,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        botonTexto,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: btnFont,
                          letterSpacing: 0.1,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Beneficio compacto
// ─────────────────────────────────────────────────────────────────────────────
class _BenefRowCompact extends StatelessWidget {
  final String texto;
  final Color color;
  final double fontSize;

  const _BenefRowCompact({
    required this.texto,
    required this.color,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 22,
            height: 22,
            margin: const EdgeInsets.only(top: 1),
            decoration: BoxDecoration(
              color: color.withOpacity(0.10),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_rounded,
              size: 14,
              color: color,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              texto,
              softWrap: true,
              overflow: TextOverflow.visible,
              style: TextStyle(
                fontSize: fontSize,
                color: const Color(0xFF374151),
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// RetiroResumenCard
// ─────────────────────────────────────────────────────────────────────────────
class RetiroResumenCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const RetiroResumenCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final twoCol = sw >= 720;
    final pad = sw < 600 ? 18.0 : 22.0;

    final personales = <Widget>[
      const _SecTitle(label: "Datos personales"),
      RetiroInfoRow(Icons.person, "Nombre", "${data["nombre"] ?? '—'}"),
      RetiroInfoRow(
        Icons.badge_outlined,
        "Apellidos",
        "${data["apellidop"] ?? '—'} ${data["apellidom"] ?? ''}".trim(),
      ),
      RetiroInfoRow(Icons.cake_outlined, "Edad", "${data["edad"] ?? '—'} años"),
      RetiroInfoRow(
        Icons.phone_outlined,
        "Teléfono",
        "(+52) ${data["telefono"] ?? '—'}",
      ),
      RetiroInfoRow(Icons.email_outlined, "Correo", "${data["email"] ?? '—'}"),
    ];

    final financieros = <Widget>[
      const _SecTitle(label: "Datos financieros"),
      RetiroInfoRow(
        Icons.attach_money,
        "Ingreso mensual",
        "\$${_fmt(data["ingresoMensual"])}",
      ),
      RetiroInfoRow(
        Icons.savings_outlined,
        "Ahorro actual",
        "\$${_fmt(data["ahorroActual"])}",
      ),
      RetiroInfoRow(
        Icons.trending_up_outlined,
        "Aporte mensual",
        "\$${_fmt(data["aporteMensual"])}",
      ),
      RetiroInfoRow(
        Icons.flag_outlined,
        "Edad de retiro deseada",
        "${data["edadRetiroDeseada"] ?? '—'} años",
      ),
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(pad),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE7EBF0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: twoCol
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: personales,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: financieros,
                  ),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...personales,
                const SizedBox(height: 8),
                ...financieros,
              ],
            ),
    );
  }

  String _fmt(dynamic v) {
    final n = v is num ? v : num.tryParse(v.toString()) ?? 0;
    return n
        .toStringAsFixed(2)
        .replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+\.)'), (m) => '${m[1]},');
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// RetiroInfoRow
// ─────────────────────────────────────────────────────────────────────────────
class RetiroInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const RetiroInfoRow(this.icon, this.label, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final isMobile = sw < 600;

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: isMobile ? 20 : 21,
            color: AppColors.joli,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: isMobile ? 14.5 : 15,
                    color: AppColors.navy,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: isMobile ? 16.0 : 17.0,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1F2A44),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// EstatusBadge
// ─────────────────────────────────────────────────────────────────────────────
class EstatusBadge extends StatelessWidget {
  final String estatus;

  const EstatusBadge({super.key, required this.estatus});

  @override
  Widget build(BuildContext context) {
    final cfg = _cfg(estatus);
    final color = cfg['color'] as Color;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.10),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        estatus,
        style: TextStyle(
          fontSize: 14.5,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }

  Map<String, dynamic> _cfg(String s) {
    switch (s.toLowerCase()) {
      case 'pendiente':
        return {'color': Colors.orange};
      case 'en revisión':
      case 'en revision':
        return {'color': Colors.blue};
      case 'aprobado':
        return {'color': Colors.green};
      case 'rechazado':
        return {'color': Colors.red};
      default:
        return {'color': Colors.grey};
    }
  }
}

class _SecTitle extends StatelessWidget {
  final String label;

  const _SecTitle({required this.label});

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        label,
        style: TextStyle(
          fontSize: sw < 600 ? 16.0 : 17.0,
          fontWeight: FontWeight.w700,
          color: AppColors.navy,
        ),
      ),
    );
  }
}