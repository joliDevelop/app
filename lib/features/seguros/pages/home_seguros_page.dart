// home_seguros_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../providers/seguros_provider.dart';
import '../widgets/seguro_card.dart';
import '../widgets/mis_seguros_section.dart';
import '../widgets/simulador_sheet.dart';
import '../models/seguro_model.dart';

class HomeSegurosPage extends StatelessWidget {
  const HomeSegurosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SegurosProvider(),
      child: const _HomeSegurosView(),
    );
  }
}

class _HomeSegurosView extends StatefulWidget {
  const _HomeSegurosView();

  @override
  State<_HomeSegurosView> createState() => _HomeSegurosViewState();
}

class _HomeSegurosViewState extends State<_HomeSegurosView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _showRightFade = true;
  bool _showLeftFade = false;

  final List<TipoSeguro?> _tabs = [
    null,
    TipoSeguro.gastosMedicosMayores,
    TipoSeguro.vida,
    TipoSeguro.danos,
    TipoSeguro.viaje,
    TipoSeguro.autoYFlotilla,
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SegurosProvider>();
    final bgColor = Theme.of(context).scaffoldBackgroundColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SUBTITLE — solo el subtítulo, sin repetir "Seguros"
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
          child: Text(
            'Protege lo que más importa',
            style: TextStyle(fontSize: 15, color: Colors.black45),
          ),
        ),

        // TABS con fade indicator de scroll
        SizedBox(
          height: 48,
          child: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification.metrics.axis == Axis.horizontal) {
                final pixels = notification.metrics.pixels;
                final max = notification.metrics.maxScrollExtent;
                setState(() {
                  _showLeftFade = pixels > 0;
                  _showRightFade = pixels < max;
                });
              }
              return false;
            },
            child: Stack(
              children: [
                TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  indicator: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: Colors.white,
                  unselectedLabelColor: AppColors.navy,
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                  dividerColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  tabs: _tabs.map((tipo) {
                    return Tab(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        child: Text(tipo?.label ?? 'Todos'),
                      ),
                    );
                  }).toList(),
                ),

                // Fade izquierdo
                if (_showLeftFade)
                  Positioned(
                    left: 0,
                    top: 0,
                    bottom: 0,
                    width: 32,
                    child: IgnorePointer(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              bgColor,
                              bgColor.withOpacity(0),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                // Fade derecho + chevron
                if (_showRightFade)
                  Positioned(
                    right: 0,
                    top: 0,
                    bottom: 0,
                    width: 52,
                    child: IgnorePointer(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                            colors: [
                              bgColor,
                              bgColor.withOpacity(0),
                            ],
                          ),
                        ),
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 6),
                        child: Icon(
                          Icons.chevron_right_rounded,
                          color: AppColors.navy.withOpacity(.4),
                          size: 20,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 16),

        // LISTA
        Expanded(
          child: AnimatedBuilder(
            animation: _tabController,
            builder: (context, _) {
              final tipo = _tabs[_tabController.index];
              final lista =
                  tipo == null ? provider.catalogo : provider.porTipo(tipo);

              return ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  ...lista.map(
                    (seguro) => SeguroCard(
                      seguro: seguro,
                      onSimular: () => SimuladorSheet.show(context, seguro),
                      onVerDetalle: () {},
                    ),
                  ),

                  const SizedBox(height: 32),

                  const Text(
                    'Mis seguros contratados',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.navy,
                    ),
                  ),
                  const SizedBox(height: 16),

                  MisSegurosSection(
                    seguros: provider.misSeguros,
                    onCancelar: provider.toggleContratado,
                  ),

                  const SizedBox(height: 32),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}