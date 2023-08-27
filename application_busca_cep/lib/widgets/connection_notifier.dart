import 'package:flutter/material.dart';

class ConnectionNotifier
    extends InheritedNotifier<ValueNotifier<Future<bool>>> {
  ConnectionNotifier({
    super.key,
    required super.notifier,
    required super.child,
  });

  static ValueNotifier<Future<bool>>? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ConnectionNotifier>()!
        .notifier;
  }
}
