\c 25 200

-1 read0`:get_started/get_started_solver.txt;

get_words_5_by_freq:{system"l utils/get_words_5_by_freq.q"};
get_words_5_by_freq[];

\l utils/functions.q
\l utils/prompt.q

prompt"Enter your first guess: ";
guess:enlist"";
.z.pi:{
    x:@[value;x;guess];
    /restart solver
    if[`restart~x;
        prompt"Restarting solver...";
        get_words_5_by_freq[];
        prompt"Enter your first guess: ";
        `guess set enlist"";
        ;:()];

    if[guess~enlist"";
        $[10h~type x;
            $[5=sum x in .Q.a;
                $[(`$x)in words_5_by_freq;
                    [`guess set enlist x;
                        fmtguess:"\"",guess[0],"\"";
                        prompt fmtguess," has been entered. ";
                        prompt"Enter the result for ",fmtguess,": ";
                        :();
                        ];
                    [prompt"Guess is not allowed. Try another guess: ";:()]
                    ];
                [prompt"Please enter a 5-letter word guess: ";:()]
                ];
            [prompt"Only char type (10h) is allowed for the guess. Enter your guess again: ";:()]
            ]
        ];

    fmtguess:"\"",guess[0],"\"";
    $[7h~type x;
        $[5=count x;
            $[all x within(0;2);
                [re:f[guess 0;x];
                    $[re=0;
                        err:"";
                        $[re=1;
                            [get_words_5_by_freq[];
                                prompt"Enter your first guess: ";
                                `guess set enlist"";
                                ;:()];
                            [`guess set enlist"";
                                prompt"Enter your next guess: ";
                                :()]]
                        ];
                    ];
                err:"All result items must be within 0 and 2. ";
                ];
            err:"The result must be a list of length 5. ";
            ];
        err:"Only long type (7h) is allowed for the result. ";
        ];
    prompt err,"Enter the result for ",fmtguess," again: ";
    }