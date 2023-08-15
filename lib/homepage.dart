import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pacman/path.dart';
import 'package:pacman/pixle.dart';
import 'package:pacman/player.dart';
import 'package:pacman/value.dart';

class Hompage extends StatefulWidget {
  const Hompage({super.key});

  @override
  State<Hompage> createState() => _HompageState();
}

class _HompageState extends State<Hompage> {
  static int numberInRow = 11;
  bool mouthClosed = false;
  bool pregame = true;
  int numberOfSquaes = numberInRow * 17;
  int player = numberInRow * 15 + 1;
  int ghost = numberInRow * 2 - 1;
  int score = 0;
  List<int> food = [];
  String direction = "right";
  void startGame() {
    // moveghost();
    pregame = false;
    getfood();
    Timer.periodic(const Duration(milliseconds: 150), (timer) {
      setState(() {
        mouthClosed = !mouthClosed;
      });
      if (food.contains(player)) {
        food.remove(player);
        score++;
      }
      switch (direction) {
        case "left":
          moveleft();
          break;
        case "right":
          moveright();
          break;
        case "up":
          moveup();
          break;
        case "down":
          movedown();
          break;
      }
    });
  }

  void moveghost() {
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      switch (direction) {
        case "left":
          moveleft();
          break;
        case "right":
          moveright();
          break;
        case "up":
          moveup();
          break;
        case "down":
          movedown();
          break;
      }
    });
  }

  void getfood() {
    for (int i = 0; i < numberOfSquaes; i++) {
      if (!bariyar.contains(i)) {
        food.add(i);
      }
    }
  }

  moveleft() {
    if (!bariyar.contains(player - 1)) {
      setState(() {
        player--;
      });
    }
  }

  moveright() {
    if (!bariyar.contains(player + 1)) {
      setState(() {
        player++;
      });
    }
  }

  moveup() {
    if (!bariyar.contains(player - numberInRow)) {
      setState(() {
        player -= numberInRow;
      });
    }
  }

  movedown() {
    if (!bariyar.contains(player + numberInRow)) {
      setState(() {
        player += numberInRow;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (details.delta.dy > 0) {
                  direction = "down";
                } else if (details.delta.dy < 0) {
                  direction = "up";
                }
              },
              onHorizontalDragUpdate: (details) {
                if (details.delta.dx > 0) {
                  direction = "right";
                } else if (details.delta.dx < 0) {
                  direction = "left";
                }
              },
              child: Container(
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: numberOfSquaes,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: numberInRow),
                  itemBuilder: (context, index) {
                    if (mouthClosed && player == index) {
                      return Padding(
                        padding: const EdgeInsets.all(4),
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Color(0xffFEFF1C)),
                        ),
                      );
                    } else if (player == index) {
                      switch (direction) {
                        case "left":
                          return Transform.rotate(
                            angle: pi,
                            child: const MyPlayer(),
                          );
                        case "right":
                          return const MyPlayer();
                        case "up":
                          return Transform.rotate(
                            angle: 3 * pi / 2,
                            child: const MyPlayer(),
                          );
                        case "down":
                          return Transform.rotate(
                            angle: pi / 2,
                            child: const MyPlayer(),
                          );
                        default:
                          return const MyPlayer();
                      }
                    } else if (bariyar.contains(index)) {
                      return MyPixle(
                        innercolor: Colors.blue[800],
                        outercolor: Colors.blue[900],
                        // child: Text(index.toString()),
                      );
                    } else if (food.contains(index) || pregame) {
                      return MyPath(
                        innercolor: Colors.yellow,
                        outercolor: Colors.black,
                      );
                    } else {
                      return const MyPath(
                        innercolor: Colors.black,
                        outercolor: Colors.black,
                      );
                    }
                    // else {
                    //   // return const MyPath(
                    //   //   innercolor: Colors.yellow,
                    //   //   outercolor: Colors.black,
                    //   // );
                    //   if (food.contains(index)) {
                    //     return MyPath(
                    //       innercolor: Colors.yellow,
                    //       outercolor: Colors.black,
                    //     );
                    //   } else {
                    //     return const MyPath(
                    //       innercolor: Colors.black,
                    //       outercolor: Colors.black,
                    //     );
                    //   }
                    // }
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Score:" + score.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                    ),
                  ),
                  GestureDetector(
                    onTap: startGame,
                    child: Text(
                      "P L A Y",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
