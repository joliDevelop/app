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

  // Tabs: Todos + los 6 tipos
  final List<TipoSeguro?> _tabs = [
    null, // Todos
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // HEADER
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Seguros',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.navy,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Protege lo que más importa',
                style: TextStyle(fontSize: 15, color: Colors.black45),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),

        // TABS horizontales scrollables
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
          labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          dividerColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          tabs: _tabs.map((tipo) {
            return Tab(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                child: Text(tipo?.label ?? 'Todos'),
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: 16),

        // LISTA
        Expanded(
          child: AnimatedBuilder(
            animation: _tabController,
            builder: (context, _) {
              final tipo = _tabs[_tabController.index];
              final lista = tipo == null
                  ? provider.catalogo
                  : provider.porTipo(tipo);

              return ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  ...lista.map((seguro) => SeguroCard(
                        seguro: seguro,
                        onSimular: () => SimuladorSheet.show(context, seguro),
                        onVerDetalle: () {},
                      )),

                  const SizedBox(height: 32),

                  // MIS SEGUROS
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