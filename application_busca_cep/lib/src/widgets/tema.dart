import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class PreferenciaTema {
  static ValueNotifier<Brightness> tema = ValueNotifier(Brightness.light);

  static setTema() {
    tema.value = WidgetsBinding.instance.platformDispatcher.platformBrightness;
  }

  static changeStatusNavigationBar() {
    bool isDark = tema.value == Brightness.dark;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarColor: isDark ? const Color(0xFF424242) : const Color.fromARGB(255, 233, 111, 41),
        systemNavigationBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: isDark ? const Color(0xFF303030) : const Color(0xFFFAFAFA),
      ),
    );
  }
}
