\c 25 200

-1 read0`:get_started/get_started_solver.txt;

\l utils/functions.q
\l utils/prompt.q

/ check if hard mode is enabled from cmd line
hardmode:"-hardmode"in .z.X;
error_messages:`error xkey("S*";enlist",")0:`:data/error_messages.csv;
start_solver:{[restart;hardmode]
    if[restart;prompt"Restarting solver..."];
    / initialize words list
    system"l utils/get_words_5_by_freq.q";
    / initialize guess
    `guess set enlist"";
    if[hardmode;prompt"Hard Mode is enabled - Any revealed hints must be used in subsequent guesses!"];
    prompt"Enter your first guess:";
    };

start_solver[0;hardmode];
.z.pi:{
    / error trap
    x:@[value;x;guess];

    / restart solver
    if[`restart~x;start_solver[1;hardmode];:()];

    / guess has not been entered
    if[guess~enlist"";
        / not correct type
        error:error_messages[
            $[not 10h~type x;`guess_type;
                / check length
                5<>sum x in .Q.a;`guess_length;
                / check word
                hardmode&not(`$x)in words_5_by_freq;`guess_word;
                / no error
                [`guess set enlist x;
                    fmtguess:"\"",guess[0],"\"";
                    prompt fmtguess," has been entered.";
                    prompt"Enter the result for ",fmtguess,":";
                    :()]
                ]
            ]`message;
        
        if[count error;prompt error;:()];
        ];

    / guess has been entered - result input
    / not correct type
    error:error_messages[
        $[not 7h~type x;`result_type;
            / check length
            5<>count x;`result_length;
            / check bounds
            not all x within(0;2);`result_bounds;
            / check result
            [result:f[guess 0;x;hardmode];
                `]];
        ]`message;

    if[(`error~result)|count error;prompt error," Enter the result for \"",guess[0],"\" again:";:()];

    / if result found - restart
    $[`found~result;start_solver[1;hardmode];
        / next guess
        [`guess set enlist"";prompt"Enter your next guess:"]];

    }