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
  bool _asesorEnLinea = true;
  bool _contactoMostrado = false;

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

  void _iniciarConversacion() {
    _mensajes.addAll([
      ChatMensaje(
        tipo: MensajeTipo.bot,
        texto: 'Hola, soy el asistente de Joli. ¿En qué tema necesitas ayuda?',
      ),
      ChatMensaje(
        tipo: MensajeTipo.opciones,
        opciones: AsesoriaData.preguntasIniciales,
      ),
    ]);
  }

  void _activarAsistente() {
    if (!_asesorEnLinea) {
      setState(() {
        _asesorEnLinea = true;
      });
    }
  }

  Future<void> _seleccionarOpcion(PreguntaOpcion opcion) async {
    _activarAsistente();

    setState(() {
      _mensajes.add(
        ChatMensaje(
          tipo: MensajeTipo.usuario,
          texto: opcion.texto,
        ),
      );
    });

    _scrollToBottom();

    if (opcion.id == 'contacto_joli') {
      await _mostrarContacto();
      return;
    }

    setState(() {
      _mostrarTyping = true;
    });

    await Future.delayed(const Duration(milliseconds: 650));
    if (!mounted) return;

    final subOpciones = opcion.subOpciones ?? [];

    setState(() {
      _mostrarTyping = false;

      if (subOpciones.isNotEmpty) {
        _mensajes.add(
          ChatMensaje(
            tipo: MensajeTipo.bot,
            texto: 'Selecciona una pregunta para ayudarte mejor:',
          ),
        );

        _mensajes.add(
          ChatMensaje(
            tipo: MensajeTipo.opciones,
            opciones: [
              ...subOpciones,
              const PreguntaOpcion(
                id: 'contacto_joli',
                texto: 'No encontré mi respuesta',
                respuesta: '',
              ),
            ],
          ),
        );
      } else {
        _mensajes.add(
          ChatMensaje(
            tipo: MensajeTipo.bot,
            texto: opcion.respuesta,
          ),
        );

        _mensajes.add(
          ChatMensaje(
            tipo: MensajeTipo.opciones,
            opciones: const [
              PreguntaOpcion(
                id: 'volver_inicio',
                texto: 'Ver otros temas',
                respuesta: '',
              ),
              PreguntaOpcion(
                id: 'contacto_joli',
                texto: 'Contactar a Joli',
                respuesta: '',
              ),
            ],
          ),
        );
      }
    });

    _scrollToBottom();
  }

  Future<void> _procesarAccionEspecial(PreguntaOpcion opcion) async {
    _activarAsistente();

    if (opcion.id == 'volver_inicio') {
      setState(() {
        _contactoMostrado = false;

        _mensajes.addAll([
          ChatMensaje(
            tipo: MensajeTipo.usuario,
            texto: opcion.texto,
          ),
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
      if (_contactoMostrado) {
        _scrollToBottom();
        return;
      }

      setState(() {
        _mensajes.add(
          ChatMensaje(
            tipo: MensajeTipo.usuario,
            texto: opcion.texto,
          ),
        );
      });

      await _mostrarContacto();
    }
  }

  Future<void> _mostrarContacto() async {
    if (_contactoMostrado) {
      _scrollToBottom();
      return;
    }

    setState(() {
      _mostrarTyping = true;
    });

    await Future.delayed(const Duration(milliseconds: 550));
    if (!mounted) return;

    setState(() {
      _mostrarTyping = false;
      _contactoMostrado = true;
      _asesorEnLinea = false;

      _mensajes.addAll([
        ChatMensaje(
          tipo: MensajeTipo.bot,
          texto:
              'No te preocupes. Puedes contactar a Joli para recibir asesoría personalizada:',
        ),
        ChatMensaje(
          tipo: MensajeTipo.contacto,
        ),
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
        _scrollController.position.maxScrollExtent + 180,
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeOutCubic,
      );
    });
  }

  void _abrirWhatsApp() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Aquí conectarás WhatsApp')),
    );
  }

  void _llamarTelefono() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Aquí conectarás la llamada')),
    );
  }

  void _enviarCorreo() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Aquí conectarás el correo')),
    );
  }

  PreferredSizeWidget? _buildAppBar() {
    return null;
  }

  Widget _buildMensaje(ChatMensaje mensaje) {
    switch (mensaje.tipo) {
      case MensajeTipo.bot:
        return BurbujaBot(texto: mensaje.texto ?? '');

      case MensajeTipo.usuario:
        return BurbujaUsuario(texto: mensaje.texto ?? '');

      case MensajeTipo.opciones:
        return OpcionesChat(
          opciones: mensaje.opciones ?? [],
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: const Color(0xFFF0F4F8),
      body: Column(
        children: [
          _ChatHeader(
            asesorEnLinea: _asesorEnLinea,
            onBack: () => Navigator.of(context).pop(),
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 10),
              itemCount: _mensajes.length + (_mostrarTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (_mostrarTyping && index == _mensajes.length) {
                  return const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: TypingIndicator(),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _buildMensaje(_mensajes[index]),
                );
              },
            ),
          ),
          if (!_contactoMostrado)
            _Footer(
              onContactar: () => _onSeleccion(
                const PreguntaOpcion(
                  id: 'contacto_joli',
                  texto: 'Contactar a Joli',
                  respuesta: '',
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ChatHeader extends StatelessWidget {
  final bool asesorEnLinea;
  final VoidCallback onBack;

  const _ChatHeader({
    required this.asesorEnLinea,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final Color estadoColor =
        asesorEnLinea ? const Color(0xFF4CAF50) : AppColors.textMuted;

    final String estadoTexto = asesorEnLinea ? 'En línea' : 'Desconectado';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(12, 16, 14, 14),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.navy, AppColors.joli],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: onBack,
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                  size: 22,
                ),
                splashRadius: 22,
                tooltip: 'Volver',
              ),
              const SizedBox(width: 2),
              const Expanded(
                child: Text(
                  'Asesoría',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.16),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.supervisor_account_sharp,
                  color: Colors.white,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Asistente Joli',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Container(
                          width: 7,
                          height: 7,
                          margin: const EdgeInsets.only(right: 5),
                          decoration: BoxDecoration(
                            color: estadoColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Text(
                          estadoTexto,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12.5,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              const SizedBox(
                width: 165,
                child: Text(
                  '¿No encuentras lo que buscas?\nContacta a un asesor.',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 11.5,
                    height: 1.35,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  final VoidCallback onContactar;

  const _Footer({
    required this.onContactar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.dark.withOpacity(0.07),
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
            icon: const Icon(
              Icons.outlinedheadset_mic_,
              color: Colors.white,
              size: 20,
            ),
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