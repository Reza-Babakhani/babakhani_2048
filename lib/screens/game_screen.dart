import 'package:audioplayers/audioplayers.dart';
import 'package:babakhani_2048/screens/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:provider/provider.dart';

import '../service/game.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key, required this.title});

  final String title;

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final audioPlayer = AudioPlayer();
  static const soundAudioPath = "audio/slide.mp3";

  bool _isInit = true;
  @override
  void didChangeDependencies() async {
    if (_isInit) {
      await Provider.of<Game>(context, listen: false)
          .fetchHighScore()
          .then((value) => {});

      _isInit = false;
    }
    super.didChangeDependencies();
  }

  Future<void> shareHighScore() async {
    await FlutterShare.share(
        title: 'Are You Played 20480',
        text:
            'Are You Played 20480? My High Score is ${Provider.of<Game>(context, listen: false).highScore}. Can you beat my record?',
        linkUrl: "https://play20480.rezababakhani.ir",
        chooserTitle: 'Share High Score');
  }

  @override
  Widget build(BuildContext context) {
    Game game = Provider.of<Game>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            IconButton(
                onPressed: () async {
                  await Navigator.of(context)
                      .pushNamed(SettingScreen.routeName);
                },
                icon: const Icon(Icons.settings_outlined))
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () async {
                      await shareHighScore();
                    },
                    icon: const Icon(Icons.share),
                  ),
                  Text(
                    "High Score: ${game.highScore > game.score ? game.highScore : game.score}",
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    width: 25,
                  )
                ],
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(game.isGameOver
                        ? "Game Over. Score: ${game.score}"
                        : (game.score == 0)
                            ? "Move the tiles to start the game."
                            : "Score: ${game.score}"),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        GestureDetector(
                          onHorizontalDragEnd: (DragEndDetails details) async {
                            if (details.primaryVelocity! < 0) {
                              // User swiped Left

                              bool isMoved = game.moveLeft();
                              if (isMoved) {
                                await audioPlayer
                                    .play(AssetSource(soundAudioPath));
                              }
                            } else if (details.primaryVelocity! > 0) {
                              // User swiped Right

                              bool isMoved = game.moveRight();
                              if (isMoved) {
                                await audioPlayer
                                    .play(AssetSource(soundAudioPath));
                              }
                            }
                          },
                          onVerticalDragEnd: (DragEndDetails details) async {
                            if (details.primaryVelocity! > 0) {
                              // User swiped Down

                              bool isMoved = game.moveDown();
                              if (isMoved) {
                                await audioPlayer
                                    .play(AssetSource(soundAudioPath));
                              }
                            } else if (details.primaryVelocity! < 0) {
                              // User swiped Up

                              bool isMoved = game.moveUp();

                              if (isMoved) {
                                await audioPlayer
                                    .play(AssetSource(soundAudioPath));
                              }
                            }
                          },
                          child: SingleChildScrollView(
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Container(
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: GridView.count(
                                  primary: false,
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: const EdgeInsets.all(10),
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  childAspectRatio: 1,
                                  crossAxisCount: game.n,
                                  children: game.tiles,
                                ),
                              ),
                            ),
                          ),
                        ),
                        if (game.isGameOver)
                          AspectRatio(
                            aspectRatio: 1,
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.black38),
                            ),
                          )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    IconButton(
                      onPressed: () async {
                        bool canReset = false;

                        if (game.isGameOver) {
                          canReset = true;
                        } else {
                          canReset = await showDialog(
                              context: context,
                              builder: (ctx) {
                                return AlertDialog(
                                  content: const Text(
                                      "Game will be restart.\n Are you sure?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(true);
                                      },
                                      child: const Text(
                                        "Yes",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(false);
                                      },
                                      child: const Text("No"),
                                    ),
                                  ],
                                );
                              });
                        }

                        if (canReset) {
                          setState(() {
                            Provider.of<Game>(context, listen: false).reset();
                          });
                        }
                      },
                      iconSize: 50,
                      icon: const Icon(Icons.restart_alt_outlined),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
