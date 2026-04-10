import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/ui_helpers.dart';
import '../widgets/retiro_widget.dart';

class RetiroPage extends StatefulWidget {
  const RetiroPage({super.key});

  @override
  State<RetiroPage> createState() => _RetiroPageState();
}

class _RetiroPageState extends State<RetiroPage> {
  final ScrollController _scroll = ScrollController();
  final GlobalKey _pprKey = GlobalKey();
  final GlobalKey _jubKey = GlobalKey();
  int? _expanded;
  bool _showTop = false;

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scroll.removeListener(_onScroll);
    _scroll.dispose();
    super.dispose();
  }

  void _onScroll() {
    final show = _scroll.offset > 200;
    if (show != _showTop) {
      setState(() => _showTop = show);
    }
  }

  void _goToTop() {
    _scroll.animateTo(
      0,
      duration: const Duration(milliseconds: 520),
      curve: Curves.easeOutCubic,
    );
  }

  GlobalKey _key(int i) => i == 0 ? _pprKey : _jubKey;

  Future<void> _scrollToCard(GlobalKey key, {bool closing = false}) async {
    await Future.delayed(Duration(milliseconds: closing ? 80 : 280));
    if (!mounted) return;

    final ctx = key.currentContext;
    if (ctx == null) return;

    final box = ctx.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return;

    final cardOffset = box.localToGlobal(
      Offset.zero,
      ancestor: context.findRenderObject(),
    );

    final currentOff = _scroll.offset;
    final targetOff = (currentOff + cardOffset.dy - 16).clamp(
      0.0,
      _scroll.position.maxScrollExtent,
    );

    await _scroll.animateTo(
      targetOff,
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeOutCubic,
    );
  }

  Future<void> _toggle(int index) async {
    final same = _expanded == index;

    if (same) {
      final key = _key(index);
      setState(() => _expanded = null);
      await WidgetsBinding.instance.endOfFrame;
      await _scrollToCard(key, closing: true);
      return;
    }

    setState(() => _expanded = index);
    await WidgetsBinding.instance.endOfFrame;
    await WidgetsBinding.instance.endOfFrame;
    await _scrollToCard(_key(index));
  }

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final isMobile = sw < 600;
    final isDesktop = sw >= 960;
    final hPad = sw < 360 ? 14.0 : isMobile ? 18.0 : sw < 960 ? 28.0 : 40.0;
    final maxW = isDesktop ? 1040.0 : 920.0;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FA),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: AnimatedSlide(
        offset: _showTop ? Offset.zero : const Offset(0, 2.5),
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeOutCubic,
        child: AnimatedOpacity(
          opacity: _showTop ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 280),
          child: FloatingActionButton.extended(
            onPressed: _showTop ? _goToTop : null,
            backgroundColor: AppColors.navy,
            elevation: 4,
            icon: const Icon(
              Icons.keyboard_arrow_up_rounded,
              color: Colors.white,
              size: 26,
            ),
            label: const Text(
              "Volver arriba",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxW),
            child: SingleChildScrollView(
              controller: _scroll,
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.fromLTRB(
                hPad,
                isMobile ? 18 : 28,
                hPad,
                120,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Hero(isMobile: isMobile, isDesktop: isDesktop),

                  SizedBox(height: isMobile ? 28 : 36),

                  Text(
                    "Elige tu plan",
                    style: TextStyle(
                      fontSize: isMobile ? 30 : isDesktop ? 38 : 34,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF1F2A44),
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Toca una opción para ver los detalles y elegir la que mejor se adapte a ti.",
                    style: TextStyle(
                      fontSize: isMobile ? 17 : 19,
                      color: Colors.black54,
                      height: 1.5,
                    ),
                  ),

                  SizedBox(height: isMobile ? 22 : 28),

                  isDesktop
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(key: _pprKey, child: _buildPPR()),
                            const SizedBox(width: 20),
                            Expanded(key: _jubKey, child: _buildJub()),
                          ],
                        )
                      : Column(
                          children: [
                            SizedBox(key: _pprKey, child: _buildPPR()),
                            const SizedBox(height: 20),
                            SizedBox(key: _jubKey, child: _buildJub()),
                          ],
                        ),

                  SizedBox(height: isMobile ? 24 : 32),

                  _AvisoLegal(isMobile: isMobile),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPPR() => ProductoCard(
        icono: Icons.savings_outlined,
        etiqueta: "Ahorro a largo plazo",
        titulo: "Plan Personal de Retiro",
        subtitulo: "PPR",
        descripcion:
            "Una opción para construir ahorro para tu retiro con beneficios fiscales y respaldo de instituciones aliadas.",
        beneficios: const [
          BeneficioItem(
            texto: "Deducible de impuestos hasta el 10% de tu ingreso anual.",
          ),
          BeneficioItem(
            texto: "Rendimientos competitivos para hacer crecer tu ahorro.",
          ),
          BeneficioItem(
            texto:
                "Tu beneficiario recibe el fondo completo en caso de fallecimiento.",
          ),
          BeneficioItem(
            texto: "Posibilidad de integrar seguros de vida y gastos médicos.",
          ),
          BeneficioItem(
            texto:
                "Disponible al cumplir 65 años o con más de 5 años de antigüedad.",
          ),
        ],
        nota:
            "Recomendado si buscas una opción de largo plazo con ventajas fiscales y protección familiar.",
        colorEtiqueta: AppColors.joli,
        botonTexto: "Solicitar PPR",
        onTap: () => go(context, '/plan-retiro/ppr/form'),
        expanded: _expanded == 0,
        onToggle: () => _toggle(0),
      );

  Widget _buildJub() => ProductoCard(
        icono: Icons.calendar_month_outlined,
        etiqueta: "Ahorro por plazo",
        titulo: "Mi Jubilación",
        subtitulo: "Ahorro programado",
        descripcion:
            "Aportas mensualmente durante 5 o 10 años y tu ahorro continúa creciendo solo hasta los 60 años.",
        beneficios: const [
          BeneficioItem(texto: "Aportaciones desde \$1,000 mensuales."),
          BeneficioItem(texto: "Tú eliges el plazo: 5 o 10 años."),
          BeneficioItem(
            texto:
                "Al terminar tu plazo, el dinero sigue creciendo sin que aportes más.",
          ),
          BeneficioItem(
            texto: "Al cumplir 60 años recibes tu fondo completo acumulado.",
          ),
          BeneficioItem(
            texto:
                "En caso de fallecimiento, tu beneficiario recibe el total del fondo.",
          ),
          BeneficioItem(
            texto:
                "En caso de enfermedad grave puedes retirar una parte antes de tiempo.",
          ),
          BeneficioItem(
            texto: "Puedes añadir seguros de vida para mayor protección.",
          ),
        ],
        nota:
            "Perfecto para empezar hoy: aportas un tiempo definido y tu dinero trabaja por ti el resto.",
        colorEtiqueta: AppColors.primary,
        botonTexto: "Solicitar Mi Jubilación",
        onTap: () => go(context, '/plan-retiro/jubilacion/form'),
        expanded: _expanded == 1,
        onToggle: () => _toggle(1),
      );
}

// HERO RESTAURADO
class _Hero extends StatelessWidget {
  final bool isMobile;
  final bool isDesktop;

  const _Hero({
    required this.isMobile,
    required this.isDesktop,
  });

  @override
  Widget build(BuildContext context) {
    final double pad = isMobile ? 20 : 28;
    final double radius = isMobile ? 26 : 30;
    final double titleSize = isMobile ? 24 : isDesktop ? 34 : 30;
    final double bodySize = isMobile ? 16.5 : 18.0;
    final double iconWrap = isMobile ? 60 : 74;
    final double iconSize = isMobile ? 30 : 38;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(pad),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0D47A1), Color(0xFF1976D2), Color(0xFF2D9CFF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1565C0).withOpacity(0.22),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: -18,
            right: -18,
            child: Container(
              width: isMobile ? 90 : 120,
              height: isMobile ? 90 : 120,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -30,
            right: isMobile ? 20 : 40,
            child: Container(
              width: isMobile ? 110 : 150,
              height: isMobile ? 110 : 150,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
            ),
          ),
          isMobile
              ? _buildMobileHero(iconWrap, iconSize, titleSize, bodySize)
              : _buildDesktopHero(iconWrap, iconSize, titleSize, bodySize),
        ],
      ),
    );
  }

  Widget _buildMobileHero(
    double iconWrap,
    double iconSize,
    double titleSize,
    double bodySize,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: iconWrap,
              height: iconWrap,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.14),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(
                Icons.account_balance_outlined,
                color: Colors.white,
                size: iconSize,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                "Planes para Ley 73",
                style: TextStyle(
                  fontSize: titleSize,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  height: 1.08,
                  letterSpacing: -0.3,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Text(
            "Opciones de ahorro claras para planear tu retiro con tranquilidad y respaldo.",
            style: TextStyle(
              fontSize: bodySize,
              color: Colors.white.withOpacity(0.92),
              height: 1.5,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: const [
            _HeroChip(
              icon: Icons.verified_outlined,
              label: "Respaldado por aliados",
            ),
            _HeroChip(
              icon: Icons.smartphone_outlined,
              label: "100% digital",
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDesktopHero(
    double iconWrap,
    double iconSize,
    double titleSize,
    double bodySize,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: iconWrap,
          height: iconWrap,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.14),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            Icons.account_balance_outlined,
            color: Colors.white,
            size: iconSize,
          ),
        ),
        const SizedBox(width: 18),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Planes para Ley 73",
                style: TextStyle(
                  fontSize: titleSize,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  height: 1.08,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Opciones de ahorro claras para planear tu retiro con tranquilidad y respaldo.",
                style: TextStyle(
                  fontSize: bodySize,
                  color: Colors.white.withOpacity(0.92),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: const [
                  _HeroChip(
                    icon: Icons.verified_outlined,
                    label: "Respaldado por aliados",
                  ),
                  _HeroChip(
                    icon: Icons.smartphone_outlined,
                    label: "100% digital",
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HeroChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _HeroChip({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final isMobile = sw < 600;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 12 : 14,
        vertical: isMobile ? 8 : 9,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.14),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Colors.white.withOpacity(0.22),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: isMobile ? 15 : 16,
          ),
          const SizedBox(width: 7),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: isMobile ? 13.5 : 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _AvisoLegal extends StatelessWidget {
  final bool isMobile;

  const _AvisoLegal({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 16 : 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE7EBF0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.shield_outlined,
            size: 22,
            color: Color(0xFF1565C0),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              "Este módulo es informativo y de orientación. La propuesta final depende de la evaluación realizada por las instituciones aliadas. No sustituye asesoría financiera personalizada.",
              style: TextStyle(
                fontSize: isMobile ? 15 : 16,
                color: const Color(0xFF4A5568),
                height: 1.55,
              ),
            ),
          ),
        ],
      ),
    );
  }
}