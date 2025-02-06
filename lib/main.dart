import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/carte_provider.dart';
import 'screens/conta_carte_screen.dart';

// Importa window_manager per il controllo della finestra (solo per Desktop)
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Evita di eseguire window_manager su Web
  if (!kIsWeb) {
    await windowManager.ensureInitialized();

    WindowOptions windowOptions = WindowOptions(
      size: Size(700, 700),
      minimumSize: Size(700, 700),
      maximumSize: Size(700, 700),
      alwaysOnTop: true,
      titleBarStyle: TitleBarStyle.normal,
    );

    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }

  runApp(
    ChangeNotifierProvider(
      create: (context) => CarteProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Conta Carte Scopa',
      theme: ThemeData(primarySwatch: Colors.green),
      home: ContaCarteScreen(),
    );
  }
}
