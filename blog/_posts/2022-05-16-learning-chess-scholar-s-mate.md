---
layout: post
title: 'learning chess: scholar''s mate'
tags: chess
date: 2022-05-16 15:11 +0530
---
Since childhood, I have made several attempts to play chess regularly and reach a level of competency where I get a good grasp on skills like board vision, openings, endgames, etc. The attempts start off well but then I forget to play or give up eventually. This is yet another attempt to do so and hopefully it will be a success or atleast this attempt should last longer than others. I am currently following a chess playlist by [NM Robert Ramirez](https://www.youtube.com/watch?v=GQvR_fLkNKo&list=PLQKBpQZcRycrvUUxLdVmlfMChJS0S5Zw0) that should cover much of the basics. But anyways, my failed attempts have taught me that studying tactics won't help if I don't play regularly.

Recently, I came across a rather interesting chess match from the [PogChamps](https://en.wikipedia.org/wiki/PogChamps) chess tournament where `xQc`, a twitch streamer was defeated by `moistCr1tikal`, another streamer in just six moves. This checkmate that lead to moistcritical's victory is quite similar to the *Scholar's mate* (which is performed in just four moves).

I know a match from PogChamps doesn't have any formal significance in the chess community but this match got me into chess (again) so I like to use it as a reference.

Here is the board arrangement for the scholar's mate that I found on [wikipedia](https://en.wikipedia.org/wiki/Scholar%27s_mate). The moves (in [PGN](https://en.wikipedia.org/wiki/Portable_Game_Notation)) that lead to this state are:
```
1. e4 e5 2. Qh5 Nc6 3. Bc4 Nf6?? 4. Qxf7#
```
> New to chess notation?
> Here are some resources that helped me get started:
> * Chess notation (PGN): [video](https://www.youtube.com/watch?v=mADPCw-rhPI)
> * FEN: [video](https://www.youtube.com/watch?v=juxiL-PM6kk)

> Psst! the board below is interactive. You can drag the pieces around thanks to [chessboard.js](https://chessboardjs.com/). (No legal move checking is performed!)

<div class="chessbox">
    <div id="board1" class="chessboard"></div>
    <p class="caption">Board: scholar's mate from wikipedia page</p>
</div>

We can compare the moves of the scholar's mate with those of the previously mentioned pogchamp match.
```
1. e4 e5 2. Kf3 Kc6 3. d4 exd4 4. Kxd4 Bc5 5. c3 Qf6 6. Kxc6 Qxf2#
```

<div class="chessbox">
    <div id="board2" class="chessboard"></div>
    <p class="caption">Board: moistCr1tikal's checkmate against xQc in pogchamps</p>
</div>

Although the attacking side is flipped in these cases but a direct comparison can be made in between the two games based the attack by the Queen on f7/f2 and the use of bishop.

This move is very effective as the f7/f2 pawn is a weak pawn in early game due to the immobility of the king.

*How to defend from this, you ask?*

A game may usually go:
```
1. e4 e5 2. Qh5
```

> Visualizing chess notation in the head is hard, try out the listed moves on the board below:
<div class="chessbox">
    <div id="board3" class="chessboard"></div>
    <p class="caption">Board: try out the moves here</p>
</div>

At this point, the best move for black is to defend the pawn at e5 and play `Nc6`, moves like `Nf6` will lead to checkmate. Moves like `Ke7??` or `g6` at this stage, will also prove disastrious.

After black plays `Nc6`, white plays `Bc4`, threatening a checkmate in the next move. The next move is crucial to prevent white's victory. Black playing `Nf6` will lead to `Qxf7` and checkmate. Best move is to play `g6` and threaten white's queen, this way the pawn at `e5` is also protected by the knight at `c6`.

White can be persistent here by playing `Qf3` and threatening to take the `f7` pawn again. Here it is advised to play `Nf6`. The final threat from white on the poor f7 pawn could be from a *[battery](https://en.wikipedia.org/wiki/Battery_(chess))* which is formed by white playing `Qb3` and then using the bishop at c4 for the attack. This will not lead to a checkmate but black would lose a pawn and the ability to castle. Black can prepare a trap here by playing `Nd4`

At this point, white could give up and go along its way to scheming other plans but if it still takes the f7 pawn. 

`Bxf7+ Ke7`

Here white has to choose between defending the bishop or losing a rook through the black knight taking the c7 pawn and the subsequent fork that leads to white losing the rook on a1. But actually the choice is not binary, white can also be smart and move its queen to c4 and defend both. Black plays `b5` and forces the white's queen to leave the bishop undefended against capture. White playing `Qb4+` and then eventually, allowing the knight on d4 to take the c2 pawn is a blunder as it leads to a threeway fork.

So we see that by carefully defending against the scholar's mate, we can make the opponent regret their decisions by making them lose a bishop (or more).

<!-- add all js code below this point -->
<script>
    var moves1 = 'r1bqkb1r/pppp1Qpp/2n2n2/4p3/2B1P3/8/PPPP1PPP/RNB1K1NR b KQkq - 0 4'
    var board1 = Chessboard('board1', {
        position: moves1,
        draggable: true,
    })

    var moves2 = 'r1b1k1nr/pppp1ppp/2N5/2b5/4P3/2P5/PP3qPP/RNBQKB1R w KQkq - 0 7'
    var board2 = Chessboard('board2', {
        position: moves2,
        draggable: true,
    })
    var board3 = Chessboard('board3', {
        position: 'start',
        draggable: true,
        orientation: 'black',
        sparePieces: true,
    })
</script>