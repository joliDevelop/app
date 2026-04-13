import 'package:flutter/material.dart';
import 'package:joli/features/asesoria/data/asesoria_model.dart';
import 'package:joli/features/asesoria/presentacion/widgets/asesoria_widget.dart';

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

  Future<void> _seleccionarOpcion(PreguntaOpcion opcion) async {
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

    await Future.delayed(const Duration(milliseconds: 700));

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
    if (opcion.id == 'volver_inicio') {
      setState(() {
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
    final yaMostroContacto =
        _mensajes.any((mensaje) => mensaje.tipo == MensajeTipo.contacto);

    if (yaMostroContacto) {
      _scrollToBottom();
      return;
    }

    setState(() {
      _mostrarTyping = true;
    });

    await Future.delayed(const Duration(milliseconds: 600));

    if (!mounted) return;

    setState(() {
      _mostrarTyping = false;
      _mensajes.addAll([
        ChatMensaje(
          tipo: MensajeTipo.bot,
          texto:
              'No te preocupes. Puedes contactar a Joli para recibir asesoría personalizada por cualquiera de estas opciones:',
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
        _scrollController.position.maxScrollExtent + 150,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
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
    if (widget.esModal) return null;

    return AppBar(
      title: const Text('Asesoría'),
      centerTitle: false,
    );
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
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: const Color(0xFFF4F7FB),
      body: SafeArea(
        child: Column(
          children: [
            if (widget.esModal)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 8, 8),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Asesoría Joli',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1F2A44),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                itemCount: _mensajes.length + (_mostrarTyping ? 1 : 0),
                itemBuilder: (context, index) {
                  if (_mostrarTyping && index == _mensajes.length) {
                    return const Padding(
                      padding: EdgeInsets.only(bottom: 6),
                      child: TypingIndicator(),
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: _buildMensaje(_mensajes[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}