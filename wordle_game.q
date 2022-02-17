\c 25 200

/ set "random" seed based on time
system"S ",string`int$.z.t

-1 each read0`:get_started/get_started_game.txt;

\l get_words_5_by_freq.q

answer:string rand words_5_by_freq;

0N!`$"Enter your first guess: ";
result:();
.z.pi:{
    /error trap
    guess:@[value;x;""];

    /restart game
    if[`restart~guess;
        0N!`;
        0N!`$"Restarting game...";
        `answer set string rand words_5_by_freq;
        0N!`;
        0N!`$"Enter your first guess: ";
        `result set();
        :()];
    
    /reveal answer
    if[`answer~guess;
        0N!`;
        0N!`$"Revealing answer...";
        0N!`;
        show result;
        0N!`;
        0N!`$"The correct answer is: \"",answer,"\"";
        :()];

    $[not""~guess;
        $[(not x in string key`.)&10h~type guess;
            $[5=sum guess in .Q.a;
                $[(`$guess)in words_5_by_freq;
                    [place:@[`long$guess in answer;where guess=answer;:;2];
                        `result upsert([guess:enlist guess] place:enlist place);
                        show result;
                        0N!`;
                        /correct answer
                        if[all place=2;
                            0N!`$"Well done! \"",string[guess 0],"\" is the correct answer.";
                            0N!`;
                            0N!`$"Restarting game...";
                            0N!`;
                            `answer set string rand words_5_by_freq;
                            0N!`$"Enter your first guess: ";
                            `result set();
                            :()];
                        0N!`$"Enter your next guess: ";
                        :()];
                    err:"Guess is not allowed. Try another guess: "
                    ];
                err:"Please enter a 5-letter word guess: "
                ];
            err:"Only char type (10h) is allowed for the guess. Enter your guess again: "
            ];
        err:"Only char type (10h) is allowed for the guess. Enter your guess again: "
        ];

    show result;
    0N!`;
    0N!`$err;
    }