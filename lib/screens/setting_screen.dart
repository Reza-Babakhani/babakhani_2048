import 'package:babakhani_2048/providers/settings.dart';
import 'package:babakhani_2048/utils/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  static const String routeName = "settings";
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var isDarkMode = Provider.of<ThemeNotifier>(context).isDarkMode();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
              child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Theme Mode:",
                    style: TextStyle(fontSize: 18),
                  ),
                  MaterialSegmentedControl(
                    children: {
                      0: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          "Light",
                          style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black),
                        ),
                      ),
                      1: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          "Dark",
                          style: TextStyle(
                              color: isDarkMode ? Colors.black : Colors.white),
                        ),
                      ),
                    },
                    selectionIndex: isDarkMode ? 1 : 0,
                    //borderColor: Colors.grey,
                    selectedColor: Colors.white,
                    unselectedColor: Colors.black,
                    borderRadius: 32.0,

                    onSegmentChosen: (index) {
                      if (index == 0) {
                        Provider.of<ThemeNotifier>(context, listen: false)
                            .setLightMode();
                      } else if (index == 1) {
                        Provider.of<ThemeNotifier>(context, listen: false)
                            .setDarkMode();
                      }
                    },
                  )
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Column Number:",
                    style: TextStyle(fontSize: 18),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(
                            color: isDarkMode ? Colors.white : Colors.black)),
                    child: Row(children: [
                      IconButton(
                        onPressed: () async {
                          int n =
                              Provider.of<GameSetting>(context, listen: false)
                                  .n;
                          if (n > 3) {
                            await Provider.of<GameSetting>(context,
                                    listen: false)
                                .setN(n - 1);
                          }
                        },
                        icon: const Icon(Icons.chevron_left_rounded),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                            Provider.of<GameSetting>(context).n.toString()),
                      ),
                      IconButton(
                          onPressed: () async {
                            int n =
                                Provider.of<GameSetting>(context, listen: false)
                                    .n;
                            if (n < 9) {
                              await Provider.of<GameSetting>(context,
                                      listen: false)
                                  .setN(n + 1);
                            }
                          },
                          icon: const Icon(Icons.chevron_right_rounded)),
                    ]),
                  )
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Base Number:",
                    style: TextStyle(fontSize: 18),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(
                            color: isDarkMode ? Colors.white : Colors.black)),
                    child: Row(children: [
                      IconButton(
                        onPressed: () async {
                          int baseNum =
                              Provider.of<GameSetting>(context, listen: false)
                                  .baseNum;
                          if (baseNum > 2) {
                            await Provider.of<GameSetting>(context,
                                    listen: false)
                                .setBaseNumber(baseNum - 1);
                          }
                        },
                        icon: const Icon(Icons.chevron_left_rounded),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(Provider.of<GameSetting>(context)
                            .baseNum
                            .toString()),
                      ),
                      IconButton(
                          onPressed: () async {
                            int baseNum =
                                Provider.of<GameSetting>(context, listen: false)
                                    .baseNum;
                            if (baseNum < 10) {
                              await Provider.of<GameSetting>(context,
                                      listen: false)
                                  .setBaseNumber(baseNum + 1);
                            }
                          },
                          icon: const Icon(Icons.chevron_right_rounded)),
                    ]),
                  )
                ],
              )
            ],
          )),
        ),
      ),
    );
  }
}
