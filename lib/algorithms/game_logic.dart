import 'package:connect_four_game/assets/colors.dart';
import 'package:flutter/material.dart';

int checkResult(int row, int col, Color player, List<List<Color>> board) {
  // Horizontal
  int count = 0;
  for (int j = col - 3; j <= col + 3; j++) {
    if (insideGrid(row, j) && board[row][j] == player) {
      count++;
      if (count >= 4) return 1;
    } else {
      count = 0;
    }
  }

  // Vertical
  count = 0;
  for (int i = row; i <= row + 3; i++) {
    if (insideGrid(i, col) && board[i][col] == player) {
      count++;
      if (count >= 4) return 2;
    } else {
      count = 0;
    }
  }

  // Diagonal (left)
  count = 0;
  for (int i = -3; i <= 3; i++) {
    int r = row + i;
    int c = col + i;
    if (insideGrid(r, c) && board[r][c] == player) {
      count++;
      if (count >= 4) return 3;
    } else {
      count = 0;
    }
  }

  // Diagonal (right)
  count = 0;
  for (int i = -3; i <= 3; i++) {
    int r = row - i;
    int c = col + i;
    if (insideGrid(r, c) && board[r][c] == player) {
      count++;
      if (count >= 4) return 4;
    } else {
      count = 0;
    }
  }

  return 0;
}

bool isDraw(List<List<Color>> board) {
  for (int column = 0; column < 7; ++column) {
    if (board[0][column] == MainColor.accentColor) {
      return false;
    }
  }
  return true;
}

bool insideGrid(int row, int column) {
  return (row > -1 && row < 6 && column > -1 && column < 7);
}
