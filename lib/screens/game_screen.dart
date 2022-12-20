import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../service/game.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key, required this.title});

  final String title;

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late Game game;

  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      game = Provider.of<Game>(context);
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.settings_outlined))
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            game.isGameOver
                ? Text("Game Over. Score: ${game.score}")
                : Text("Score: ${game.score}"),
            Stack(
              alignment: Alignment.center,
              children: [
                GestureDetector(
                  onHorizontalDragEnd: (DragEndDetails details) {
                    if (details.primaryVelocity! < 0) {
                      // User swiped Left

                      game.moveLeft();
                    } else if (details.primaryVelocity! > 0) {
                      // User swiped Right

                      game.moveRight();
                    }
                  },
                  onVerticalDragEnd: (DragEndDetails details) {
                    if (details.primaryVelocity! > 0) {
                      // User swiped Down

                      game.moveDown();
                    } else if (details.primaryVelocity! < 0) {
                      // User swiped Up

                      game.moveUp();
                    }
                  },
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
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
              onPressed: () {
                setState(() {
                  Provider.of<Game>(context, listen: false).reset();
                });
              },
              iconSize: 50,
              icon: const Icon(Icons.restart_alt_outlined),
            )
          ],
        ));
  }
}
