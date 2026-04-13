enum MensajeTipo { usuario, bot, opciones, contacto }

class ChatMensaje {
  final MensajeTipo tipo;
  final String? texto;
  final List<PreguntaOpcion>? opciones;
  final DateTime timestamp;

  ChatMensaje({
    required this.tipo,
    this.texto,
    this.opciones,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}

class PreguntaOpcion {
  final String id;
  final String texto;
  final String respuesta;
  final List<PreguntaOpcion>? subOpciones;

  const PreguntaOpcion({
    required this.id,
    required this.texto,
    required this.respuesta,
    this.subOpciones,
  });
}

class AsesoriaData {
  static const List<PreguntaOpcion> preguntasIniciales = [
    PreguntaOpcion(
      id: 'seguros',
      texto: '🛡️ Seguros',
      respuesta: '',
      subOpciones: [
        PreguntaOpcion(
          id: 'seguros_1',
          texto: '¿Qué tipos de seguros ofrecen?',
          respuesta:
              'En Joli contamos con seguros de vida, gastos médicos mayores, auto y seguros de retiro. Cada uno está diseñado para protegerte a ti y a tu familia en distintas etapas de la vida.',
        ),
        PreguntaOpcion(
          id: 'seguros_2',
          texto: '¿Cómo contrato un seguro?',
          respuesta:
              'Puedes contratar tu seguro directamente desde la app en la sección "Seguros". Selecciona el tipo que necesitas, captura tus datos y un asesor se pondrá en contacto contigo para finalizar el proceso.',
        ),
        PreguntaOpcion(
          id: 'seguros_3',
          texto: '¿Puedo agregar beneficiarios?',
          respuesta:
              'Sí. Al momento de contratar tu seguro podrás registrar uno o más beneficiarios. También puedes actualizarlos más adelante contactando a tu asesor Joli.',
        ),
        PreguntaOpcion(
          id: 'seguros_4',
          texto: '¿Cómo reporto un siniestro?',
          respuesta:
              'Para reportar un siniestro, contacta a tu asesor o comunícate directamente con nosotros por WhatsApp, teléfono o correo. Te guiaremos paso a paso en el proceso.',
        ),
      ],
    ),
    PreguntaOpcion(
      id: 'retiro',
      texto: '🏦 Plan de Retiro',
      respuesta: '',
      subOpciones: [
        PreguntaOpcion(
          id: 'retiro_1',
          texto: '¿Qué es el Plan Personal de Retiro (PPR)?',
          respuesta:
              'El PPR es un instrumento de ahorro a largo plazo que te ayuda a acumular recursos para tu retiro. Tiene beneficios fiscales importantes: puedes deducir hasta el 10% de tu ingreso anual en tu declaración.',
        ),
        PreguntaOpcion(
          id: 'retiro_2',
          texto: '¿Qué es "Mi Jubilación"?',
          respuesta:
              'Mi Jubilación es un plan de ahorro programado a 5 o 10 años. Aportas desde \$1,000 mensuales durante ese plazo y al terminarlo, tu dinero sigue creciendo solo hasta que cumplas 60 años, cuando recibes tu fondo completo.',
        ),
        PreguntaOpcion(
          id: 'retiro_3',
          texto: '¿Puedo retirar mi dinero antes?',
          respuesta:
              'En el PPR puedes acceder al fondo al cumplir 65 años o con más de 5 años de antigüedad. En Mi Jubilación, en caso de enfermedad grave puedes retirar una parte del ahorro antes de tiempo.',
        ),
        PreguntaOpcion(
          id: 'retiro_4',
          texto: '¿Qué pasa si fallezco?',
          respuesta:
              'En ambos productos, si llegara a fallecer, tu beneficiario designado recibirá el fondo acumulado. Es importante registrar un beneficiario al momento de contratar.',
        ),
      ],
    ),
    PreguntaOpcion(
      id: 'cuenta',
      texto: '👤 Mi cuenta',
      respuesta: '',
      subOpciones: [
        PreguntaOpcion(
          id: 'cuenta_1',
          texto: '¿Cómo cambio mi contraseña?',
          respuesta:
              'Ve a la sección de perfil en el menú principal y selecciona "Seguridad". Desde ahí puedes cambiar tu contraseña ingresando la actual y la nueva.',
        ),
        PreguntaOpcion(
          id: 'cuenta_2',
          texto: '¿Cómo actualizo mis datos personales?',
          respuesta:
              'Puedes actualizar tus datos desde tu perfil. Para cambios importantes como nombre o RFC, será necesario contactar a un asesor Joli.',
        ),
        PreguntaOpcion(
          id: 'cuenta_3',
          texto: '¿Cómo elimino mi cuenta?',
          respuesta:
              'Para solicitar la eliminación de tu cuenta, comunícate con nosotros directamente. Un asesor te acompañará en el proceso asegurando que tus productos activos sean atendidos correctamente.',
        ),
      ],
    ),
    PreguntaOpcion(
      id: 'pagos',
      texto: '💳 Pagos y facturación',
      respuesta: '',
      subOpciones: [
        PreguntaOpcion(
          id: 'pagos_1',
          texto: '¿Cómo realizo mi pago mensual?',
          respuesta:
              'Los pagos se realizan de forma automática con el método que registraste al contratar. También puedes hacer pagos manuales desde la sección de tu producto en la app.',
        ),
        PreguntaOpcion(
          id: 'pagos_2',
          texto: '¿Puedo obtener factura?',
          respuesta:
              'Sí. Para solicitar tu factura comunícate con tu asesor o escríbenos al correo de atención. Necesitarás proporcionar tu RFC y datos fiscales.',
        ),
        PreguntaOpcion(
          id: 'pagos_3',
          texto: '¿Qué pasa si no pago a tiempo?',
          respuesta:
              'Si tu pago no se procesa en la fecha acordada, te notificaremos por la app. Según el producto, puede haber un periodo de gracia. Contáctanos para evitar afectaciones a tu cobertura.',
        ),
      ],
    ),
    PreguntaOpcion(
      id: 'app',
      texto: '📱 Uso de la app',
      respuesta: '',
      subOpciones: [
        PreguntaOpcion(
          id: 'app_1',
          texto: '¿Cómo descargo la app?',
          respuesta:
              'La app Joli está disponible en App Store (iOS) y Google Play (Android). Busca "Joli" y descárgala gratis.',
        ),
        PreguntaOpcion(
          id: 'app_2',
          texto: 'No puedo iniciar sesión, ¿qué hago?',
          respuesta:
              'Verifica que tu correo y contraseña sean correctos. Si olvidaste tu contraseña, usa la opción "¿Olvidaste tu contraseña?" en la pantalla de inicio. Si el problema persiste, contáctanos.',
        ),
        PreguntaOpcion(
          id: 'app_3',
          texto: 'La app no carga correctamente',
          respuesta:
              'Intenta cerrar la app completamente y volver a abrirla. Si el problema continúa, verifica tu conexión a internet o actualiza la app a la versión más reciente.',
        ),
      ],
    ),
  ];
}