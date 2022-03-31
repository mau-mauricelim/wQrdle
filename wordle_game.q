\c 25 200

/ set "random" seed based on time
system"S ",string`int$.z.t;

-1 read0`:get_started/get_started_game.txt;

\l utils/get_words_5_by_freq.q
\l utils/functions.q
\l utils/prompt.q

/ check if hard mode is enabled from cmd line
hardmode:"-hardmode"in .z.X;
error_messages:`error xkey("S*";enlist",")0:`:data/error_messages.csv;
start_game:{[restart;hardmode]
    if[restart;prompt"Restarting game..."];
    / set random answer
    `answer set string rand words_5_by_freq;
    / initialize result
    `result set();
    if[hardmode;prompt"Hard Mode is enabled - Any revealed hints must be used in subsequent guesses!"];
    prompt"Enter your first guess:";
    };
show_result:{-1"";show result;};

start_game[0;hardmode];
.z.pi:{
    / error trap
    guess:@[value;x;""];

    / restart game
    if[`restart~guess;start_game[1;hardmode];:()];
    
    / reveal answer
    if[`answer~guess;
        prompt"Revealing answer...";
        show_result[];
        prompt"The correct answer is: \"",answer,"\"";
        :()];

    / error trapped OR variable name is entered OR not correct type
    error:error_messages[
        $[(""~guess)|(x in string key`.)|not 10h~type guess;`guess_type;
            / check length
            5<>sum guess in .Q.a;`guess_length;
            / check word
            not(`$guess)in words_5_by_freq;`guess_word;
            `]
        ]`message;

    if[count error;show_result[];prompt error;:()];
    
    / guess entered successfully
    place:@[`long$guess in answer;where guess=answer;:;2];
    if[hardmode;f[guess;place;hardmode]];
    `result upsert([guess:enlist guess] place:enlist place);
    show_result[];

    / correct answer
    if[all place=2;
        prompt"Well done! \"",string[guess 0],"\" is the correct answer.";
        start_game[1;hardmode];
        :()];

    prompt"Enter your next guess:";
    }