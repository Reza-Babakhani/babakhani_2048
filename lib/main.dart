import 'package:babakhani_2048/providers/settings.dart';
import 'package:babakhani_2048/screens/game_screen.dart';
import 'package:babakhani_2048/screens/loading_screen.dart';
import 'package:babakhani_2048/screens/setting_screen.dart';
import 'package:babakhani_2048/service/game.dart';
import 'package:babakhani_2048/utils/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapsell_plus/tapsell_plus.dart';

void main() {
  runApp(const MyApp());

  const appId =
      "mngtctbprjnedsmijgbmttpoqsmnghfiaengpglacckogsrpcqideicpftapinkrlhfhrs";
  TapsellPlus.instance.initialize(appId);
  TapsellPlus.instance.setGDPRConsent(true);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<ThemeNotifier>(create: (_) => ThemeNotifier()),
          ChangeNotifierProvider<GameSetting>(create: (ctx) => GameSetting()),
          ChangeNotifierProxyProvider<GameSetting, Game>(
            update: (ctx, setting, game) => Game(setting),
            create: (ctx) => Game(null),
          ),
        ],
        child: Consumer<ThemeNotifier>(builder: (context, theme, _) {
          return MaterialApp(
            title: '2048',
            debugShowCheckedModeBanner: false,
            theme: theme.getTheme(),
            home: FutureBuilder(
              future: Provider.of<GameSetting>(context, listen: false).fetch(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return const GameScreen(title: '20480');
                } else {
                  return const LoadingScreen();
                }
              },
            ),
            routes: {SettingScreen.routeName: (ctx) => const SettingScreen()},
          );
        }));
  }
}
