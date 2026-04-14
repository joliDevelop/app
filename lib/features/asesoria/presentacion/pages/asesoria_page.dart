// presentacion/pages/asesoria_page.dart

import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/asesoria_model.dart';
import '../widgets/asesoria_widget.dart';

class AsesoriaPage extends StatefulWidget {
  final bool esModal;

  const AsesoriaPage({
    super.key,
    this.esModal = false,
  });

  @override
  State<AsesoriaPage> createState() => _AsesoriaPageState();
}

class _AsesoriaPageState extends State<AsesoriaPage> {
  final List<ChatMensaje> _mensajes = [];
  final ScrollController _scrollController = ScrollController();
  bool _mostrarTyping = false;

  @override
  void initState() {
    super.initState();
    _iniciarConversacion();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // ── Inicio ─────────────────────────────────────────────────────────────────
  void _iniciarConversacion() {
    _mensajes.addAll([
      ChatMensaje(
        tipo: MensajeTipo.bot,
        texto:
            'Hola, soy el asistente de Joli. ¿En qué tema necesitas ayuda?',
      ),
      ChatMensaje(
        tipo: MensajeTipo.opciones,
        opciones: AsesoriaData.preguntasIniciales,
      ),
    ]);
  }

  // ── Selección de opción ───────────────────────────────────────────────────
  Future<void> _seleccionarOpcion(PreguntaOpcion opcion) async {
    setState(() {
      _mensajes.add(ChatMensaje(
          tipo: MensajeTipo.usuario, texto: opcion.texto));
    });
    _scrollToBottom();

    if (opcion.id == 'contacto_joli') {
      await _mostrarContacto();
      return;
    }

    setState(() => _mostrarTyping = true);
    await Future.delayed(const Duration(milliseconds: 700));
    if (!mounted) return;

    final subOpciones = opcion.subOpciones ?? [];

    setState(() {
      _mostrarTyping = false;

      if (subOpciones.isNotEmpty) {
        _mensajes.add(ChatMensaje(
          tipo: MensajeTipo.bot,
          texto: 'Selecciona una pregunta para ayudarte mejor:',
        ));
        _mensajes.add(ChatMensaje(
          tipo: MensajeTipo.opciones,
          opciones: [
            ...subOpciones,
            const PreguntaOpcion(
              id: 'contacto_joli',
              texto: 'No encontré mi respuesta',
              respuesta: '',
            ),
          ],
        ));
      } else {
        _mensajes.add(ChatMensaje(
            tipo: MensajeTipo.bot, texto: opcion.respuesta));
        _mensajes.add(ChatMensaje(
          tipo: MensajeTipo.opciones,
          opciones: const [
            PreguntaOpcion(
                id: 'volver_inicio',
                texto: 'Ver otros temas',
                respuesta: ''),
            PreguntaOpcion(
                id: 'contacto_joli',
                texto: 'Contactar a Joli',
                respuesta: ''),
          ],
        ));
      }
    });

    _scrollToBottom();
  }

  Future<void> _procesarAccionEspecial(PreguntaOpcion opcion) async {
    if (opcion.id == 'volver_inicio') {
      setState(() {
        _mensajes.addAll([
          ChatMensaje(
              tipo: MensajeTipo.usuario, texto: opcion.texto),
          ChatMensaje(
            tipo: MensajeTipo.bot,
            texto: 'Claro. Aquí tienes nuevamente los temas disponibles:',
          ),
          ChatMensaje(
            tipo: MensajeTipo.opciones,
            opciones: AsesoriaData.preguntasIniciales,
          ),
        ]);
      });
      _scrollToBottom();
      return;
    }

    if (opcion.id == 'contacto_joli') {
      setState(() {
        _mensajes.add(ChatMensaje(
            tipo: MensajeTipo.usuario, texto: opcion.texto));
      });
      await _mostrarContacto();
    }
  }

  Future<void> _mostrarContacto() async {
    final yaMostro =
        _mensajes.any((m) => m.tipo == MensajeTipo.contacto);
    if (yaMostro) {
      _scrollToBottom();
      return;
    }

    setState(() => _mostrarTyping = true);
    await Future.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;

    setState(() {
      _mostrarTyping = false;
      _mensajes.addAll([
        ChatMensaje(
          tipo: MensajeTipo.bot,
          texto:
              'No te preocupes. Puedes contactar a Joli para recibir asesoría personalizada:',
        ),
        ChatMensaje(tipo: MensajeTipo.contacto),
      ]);
    });
    _scrollToBottom();
  }

  void _onSeleccion(PreguntaOpcion opcion) {
    if (opcion.id == 'volver_inicio' || opcion.id == 'contacto_joli') {
      _procesarAccionEspecial(opcion);
      return;
    }
    _seleccionarOpcion(opcion);
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 160,
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeOutCubic,
      );
    });
  }

  // ── Acciones de contacto ──────────────────────────────────────────────────
  void _abrirWhatsApp() => ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Aquí conectarás WhatsApp')),
      );

  void _llamarTelefono() => ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Aquí conectarás la llamada')),
      );

  void _enviarCorreo() => ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Aquí conectarás el correo')),
      );

  // ── Reiniciar ─────────────────────────────────────────────────────────────
  void _reiniciar() {
    setState(() {
      _mensajes.clear();
      _mostrarTyping = false;
      _iniciarConversacion();
    });
  }

  // ── AppBar ────────────────────────────────────────────────────────────────
  PreferredSizeWidget? _buildAppBar() {
    if (widget.esModal) return null;
    return AppBar(
      backgroundColor: AppColors.joli,
      title: const Text('Asesoría',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
      centerTitle: false,
      iconTheme: const IconThemeData(color: Colors.white),
      actions: [
        IconButton(
          onPressed: _reiniciar,
          icon: const Icon(Icons.refresh_rounded),
          color: Colors.white,
          tooltip: 'Reiniciar',
        ),
      ],
    );
  }

  // ── Build mensaje ─────────────────────────────────────────────────────────
  Widget _buildMensaje(ChatMensaje msg) {
    switch (msg.tipo) {
      case MensajeTipo.bot:
        return BurbujaBot(texto: msg.texto ?? '');
      case MensajeTipo.usuario:
        return BurbujaUsuario(texto: msg.texto ?? '');
      case MensajeTipo.opciones:
        return OpcionesChat(
          opciones: msg.opciones ?? [],
          onSeleccion: _onSeleccion,
        );
      case MensajeTipo.contacto:
        return ContactoCard(
          onWhatsApp: _abrirWhatsApp,
          onTelefono: _llamarTelefono,
          onCorreo: _enviarCorreo,
        );
    }
  }

  // ── Build principal ───────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: const Color(0xFFF0F4F8),
      body: Column(
        children: [
          // ── Header modal o banner ──────────────────────────────────────
          if (widget.esModal)
            _ModalHeader(onReiniciar: _reiniciar)
          else
            _BannerChat(),

          // ── Lista de mensajes ──────────────────────────────────────────
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              itemCount:
                  _mensajes.length + (_mostrarTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (_mostrarTyping && index == _mensajes.length) {
                  return const Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: TypingIndicator(),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: _buildMensaje(_mensajes[index]),
                );
              },
            ),
          ),

          // ── Footer fijo ────────────────────────────────────────────────
          _Footer(
            onContactar: () => _onSeleccion(const PreguntaOpcion(
              id: 'contacto_joli',
              texto: 'Contactar a Joli',
              respuesta: '',
            )),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Header modal (cuando esModal = true)
// ─────────────────────────────────────────────────────────────────────────────
class _ModalHeader extends StatelessWidget {
  final VoidCallback onReiniciar;
  const _ModalHeader({required this.onReiniciar});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.navy, AppColors.joli],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.support_agent,
                color: Colors.white, size: 20),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Asistente Joli',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Row(
                children: [
                  Container(
                    width: 7,
                    height: 7,
                    margin: const EdgeInsets.only(right: 5),
                    decoration: const BoxDecoration(
                      color: Color(0xFF4CAF50),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const Text(
                    'En línea',
                    style: TextStyle(
                        color: Colors.white70, fontSize: 12.5),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: onReiniciar,
            icon: const Icon(Icons.refresh_rounded,
                color: Colors.white70, size: 22),
            tooltip: 'Reiniciar',
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Banner del chat (cuando esModal = false, pantalla completa)
// ─────────────────────────────────────────────────────────────────────────────
class _BannerChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.navy, AppColors.joli],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.support_agent,
                color: Colors.white, size: 22),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Asistente Joli',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Row(
                children: [
                  Container(
                    width: 7,
                    height: 7,
                    margin: const EdgeInsets.only(right: 5),
                    decoration: const BoxDecoration(
                      color: Color(0xFF4CAF50),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const Text(
                    'En línea',
                    style: TextStyle(
                        color: Colors.white70, fontSize: 12.5),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          const Text(
            '¿No encuentras lo que buscas?\nContacta a un asesor.',
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 11.5,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Footer fijo con botón de contacto directo
// ─────────────────────────────────────────────────────────────────────────────
class _Footer extends StatelessWidget {
  final VoidCallback onContactar;
  const _Footer({required this.onContactar});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.dark.withValues(alpha: 0.07),
            blurRadius: 14,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.joli,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            onPressed: onContactar,
            icon: const Icon(Icons.headset_mic_rounded,
                color: Colors.white, size: 20),
            label: const Text(
              'Hablar con un asesor',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 15.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}