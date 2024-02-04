import 'package:flutter/material.dart';

class RendererController {
  final ValueNotifier<String> _notifier = ValueNotifier('');

  void refresh() {
    _notifier.value = DateTime.now().toString();
  }

  String get value => _notifier.value;
  set value(String v) => _notifier.value = v;

  void addListener(VoidCallback listener) {
    _notifier.addListener(listener);
  }

  void removeListener(VoidCallback listener) {
    _notifier.removeListener(listener);
  }

  void dispose() {
    _notifier.dispose();
  }
}
