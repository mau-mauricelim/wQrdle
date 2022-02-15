\l get_started.q

\l get_words_5_by_freq.q

\l functions.q

`$"Enter your first guess: "
guess:enlist""
.z.pi:{
    x:@[value;x;guess];
    if[guess~enlist"";
        $[10h~type x;
            $[5=sum x in .Q.a;
                $[(`$x)in words_5_by_freq;
                    [`guess set enlist x;
                        0N!`;
                        fmtguess:"\"",guess[0],"\"";
                        0N!`$fmtguess," has been entered. ";
                        0N!`$"Enter the result for ",fmtguess,": ";
                        :()
                        ];
                    [0N!`;0N!`$"Guess is not allowed. Try another guess: ";:()]
                    ];
                [0N!`;0N!`$"Please enter a 5-letter word guess: ";:()]
                ];
            [0N!`;0N!`$"Only char type (10h) is allowed for the guess. Enter your guess again: ";:()]
            ]
        ];

    fmtguess:"\"",guess[0],"\"";
    $[7h~type x;
        $[5=count x;
            $[all x within(0;2);
                [f[guess 0;x];`guess set enlist"";
                    0N!`;0N!`$"Enter your next guess: ";:()
                    ];
                err:"All result items must be within 0 and 2. "
                ];
            err:"The result must be a list of length 5. "
            ];
        err:"Only long type (7h) is allowed for the result. "
        ];
    0N!`;
    0N!`$err,"Enter the result for ",fmtguess," again: "
    }