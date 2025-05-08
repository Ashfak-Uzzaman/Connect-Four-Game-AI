import 'dart:math';
import 'dart:ui';
import 'package:connect_four_game/algorithms/game_logic.dart';
import 'package:connect_four_game/assets/colors.dart';

const int maxDepth = 10;
const int negativeInfinite = -9999;
const int infinite = 9999;
const int numberOfRow = 6;

const Color aI = MainColor.player2Color; // Maximizing player
const Color human = MainColor.player1Color; // Minimizing player

int findBestMove(List<List<Color>> board) {
  int bestMove = -1; // initialize the best move, nothing.
  int bestValue = negativeInfinite;
  for (int row = numberOfRow - 1; row >= 0; --row) {
    for (int column = 0; column < numberOfRow + 1; ++column) {
      if (board[row][column] == MainColor.accentColor) {
        if (row + 1 < numberOfRow &&
            board[row + 1][column] == MainColor.accentColor) {
          continue;
        }

        board[row][column] = aI;

        int moveValue =
            minimax(row, column, false, negativeInfinite, infinite, 2, board);
        board[row][column] = MainColor.accentColor;

        if (moveValue > bestValue) {
          bestValue = moveValue;
          bestMove = column;
        }
      }
    }
  }
  return bestMove;
}

int minimax(int row, int column, bool isMax, int alpha, int beta, int depth,
    List<List<Color>> board) {
  if (checkResult(row, column, aI, board) > 0) {
    return 1; // AI won
  }
  if (checkResult(row, column, human, board) > 0) {
    return -1; // Human won
  }

  if (isDraw(board) || depth == maxDepth) {
    return 0; // Draw/ Neutral
  }
  if (isMax) {
    int best = negativeInfinite;

    for (int i = numberOfRow - 1; i >= 0; --i) {
      for (int j = 0; j < numberOfRow + 1; ++j) {
        if (board[i][j] == MainColor.accentColor) {
          if (i + 1 < numberOfRow && board[i + 1][j] == MainColor.accentColor) {
            continue;
          }

          board[i][j] = aI;

          best = max(best, minimax(i, j, false, alpha, beta, depth + 1, board));
          board[i][j] = MainColor.accentColor;
          alpha = max(alpha, best);

          //Pruning
          if (alpha >= beta) {
            return best;
          }
        }
      }
    }
    return best;
  } else {
    int best = infinite;
    for (int i = numberOfRow - 1; i >= 0; --i) {
      for (int j = 0; j < numberOfRow + 1; ++j) {
        if (board[i][j] == MainColor.accentColor) {
          if (i + 1 < numberOfRow && board[i + 1][j] == MainColor.accentColor) {
            continue;
          }

          board[i][j] = human;

          best = min(best, minimax(i, j, true, alpha, beta, depth + 1, board));
          board[i][j] = MainColor.accentColor;
          beta = min(beta, best);

          // Pruning
          if (alpha >= beta) {
            return best;
          }
        }
      }
    }
    return best;
  }
}
