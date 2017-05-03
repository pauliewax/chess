# Chess

Play chess in the terminal. Built with ruby.

![chess]

## Engine Implementation Details

The board is rendered in the terminal using basic unicode characters, and a trackable cursor allows players to select either a piece or a potential move endpoint at the appropriate times. The board is re-rendered whenever the cursor is moved or a turn is attempted, in order to represent the latest gamestate. Piece classes handle their own movement logic, able to determine the possible valid moves available to that piecetype from any given position. The game includes custom errors for invalid move attempts, and notifies players of either check or checkmate conditions.

## Features In Progress

In the future, the game will implement an optional computer player with predictive AI. The computer's gameplay decisions will be dictated by duping the current boardstate and playing out hypothetical rounds in order to determine the most statistically savvy move.


[chess]: ./chess.png
