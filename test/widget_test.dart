// Este test sirve para verificar que la aplicación arranca correctamente
// No prueba lógica de negocio, solo que la UI básica se construye.

import 'package:flutter_test/flutter_test.dart';
import 'package:joli/app/app.dart';

void main() {
  testWidgets('App builds', (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    expect(find.text('Login'), findsOneWidget);
  });
}
