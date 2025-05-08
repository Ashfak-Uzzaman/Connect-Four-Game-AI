import 'package:connect_four_game/algorithms/game_logic.dart';
import 'package:connect_four_game/algorithms/minimax.dart';
import 'package:connect_four_game/assets/colors.dart';
import 'package:connect_four_game/components/button.dart';

import 'package:connect_four_game/components/text.dart';
import 'package:flutter/material.dart';

class AIGameScreen extends StatefulWidget {
  const AIGameScreen({super.key});

  @override
  State<AIGameScreen> createState() => _AIGameScreenState();
}

class _AIGameScreenState extends State<AIGameScreen> {
  bool gameEnd = true;

  int aIPlayerScore = 0;
  int humanPlayerScore = 0;

  String instruction = '';
  String startButtonText = 'Click to Start';

  static const Color humanPlayer = MainColor.player1Color;
  static const Color aIPlayer = MainColor.player2Color;

  bool firstTurnHuman = true;
  bool humanActive = true;
  // Board/Grid's cell color.
  List<List<Color>> board = List.generate(
    6,
    (_) => List.generate(7, (_) => MainColor.accentColor),
  );

  // Grid's cell border color. Will change at winning stage
  List<List<double>> cellBorders = List.generate(
    6,
    (_) => List.generate(7, (_) => 0.0),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColor.primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(20.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 23,
                      ),
                      MainText(
                        text: 'You',
                        fontSize: 35,
                        color: MainColor.accentColor,
                      ),
                      MainText(
                        text: '$humanPlayerScore',
                        fontSize: 40,
                        color: MainColor.accentColor,
                      ),
                    ],
                  ),
                  SizedBox(width: 60),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 23,
                      ),
                      MainText(
                        text: 'Machine',
                        fontSize: 35,
                        color: MainColor.accentColor,
                      ),
                      MainText(
                        text: '$aIPlayerScore',
                        fontSize: 40,
                        color: MainColor.accentColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: MainColor.boardColor,
                    //border: Border(),
                  ),
                  //color: MainColor.boardColor,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 49,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 7),
                      itemBuilder: (BuildContext context, int index) {
                        if (index < 7) {
                          return Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(25),
                              splashColor: Colors.red,
                              onTap: () async {
                                if (!gameEnd &&
                                    board[0][index] == MainColor.accentColor &&
                                    humanActive) {
                                  updateBoard(index, humanPlayer);

                                  await Future.delayed(
                                      Duration(milliseconds: 1000));
                                  if (!gameEnd) {
                                    int aIMove = findBestMove(board);

                                    updateBoard(aIMove, aIPlayer);
                                  }
                                } else if (gameEnd) {
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Click to Start/Restart Button')));
                                  }
                                } else {
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content:
                                                Text('This Column is Full.')));
                                  }
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Icon(
                                  Icons.arrow_drop_down_circle_outlined,
                                  color: MainColor.primaryColor,
                                  size: 46,
                                ),
                              ),
                            ),
                          );
                        } else {
                          int boardIndex = index - 7;
                          int row = boardIndex ~/ 7; // integer division
                          int column = boardIndex % 7;

                          return Padding(
                            padding: const EdgeInsets.all(4.5),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: board[row][column],
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: MainColor.winningColor,
                                      width: cellBorders[row][column])),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(children: [
                SizedBox(
                  height: 25,
                ),
                Center(
                  child: MainText(
                    text: instruction,
                    fontSize: 40,
                    color: MainColor.accentColor,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: MainButton(
                    onTap: () {
                      initializeBoard();
                    },
                    backGroundColor: MainColor.accentColor,
                    splashColor: MainColor.accentColor,
                    text: startButtonText,
                    fontSize: 20,
                    fontColor: MainColor.primaryColor,
                    borderRadious: 35.0,
                  ),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }

  Future<void> initializeBoard() async {
    board = List.generate(
      6,
      (_) => List.generate(7, (_) => MainColor.accentColor),
    );

    if (firstTurnHuman) {
      gameEnd = false;
      humanActive = true;

      setState(() {
        instruction = 'Your Turn';
        startButtonText = 'Restart';
      });
    } else {
      gameEnd = false;
      humanActive = false;
      setState(() {
        instruction = 'Machine\'s Turn';
        startButtonText = 'Restart';
      });
      await Future.delayed(Duration(milliseconds: 1000));

      int aIMove = findBestMove(board);
      updateBoard(aIMove, aIPlayer);
    }

    firstTurnHuman = !firstTurnHuman;
  }

  void updateBoard(int column, Color player) {
    int row = 0;
    for (row = 0; row < 6; ++row) {
      int nextRow = row + 1;

      if (nextRow < 6 && board[nextRow][column] != MainColor.accentColor) {
        // found filled cell
        board[row][column] = player;

        break;
      } else if (row == 5) {
        // for the depth most cell
        board[row][column] = player;

        break;
      } else {
        // continue falling
        board[row][column] = player;
      }
      //setState(() {});
      //await Future.delayed(Duration(milliseconds: 20));
      //setState(() {});
      board[row][column] = MainColor.accentColor;
    }

    humanActive = !humanActive;
    instruction = humanActive ? 'Your Turn' : 'Machine\'s Turn';
    int result = checkResult(row, column, player, board);
    if (result > 0) {
      if (player == humanPlayer) {
        instruction = 'You Won';
        ++humanPlayerScore;
      } else {
        instruction = 'Machine Won';
        ++aIPlayerScore;
      }
      gameEnd = true;
      startButtonText = 'Play Again';
    } else if (isDraw(board)) {
      instruction = 'Drawn';
      gameEnd = true;
      startButtonText = 'Play Again';
    }

    setState(() {});
  }
}
