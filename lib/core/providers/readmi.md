
# Como mandar llamar las 2 variables globales desde cualquier lugar 
final user = context.watch<SesionProvider>().user;
final token = context.read<SesionProvider>().token;
final isLogged = context.watch<SesionProvider>().isLogged;


# IMPORTA ESTOS 2 
# accede a las funciones
import 'sesion_provider.dart';
# acceda a libreria blobal
import 'package:provider/provider.dart'; 



| Método   | Uso                      |
| -------- | ------------------------ |
| `read`   | solo obtener el provider |
| `watch`  | escuchar cambios         |
| `select` | escuchar solo un campo   |
