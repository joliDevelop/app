// Spinner para esperar q se ralicen siertas peticiones a la API 

import 'package:flutter/material.dart';

class LoadingService {
  static final ValueNotifier<bool> isLoading = ValueNotifier(false);

  static void show() => isLoading.value = true;
  static void hide() => isLoading.value = false;
}