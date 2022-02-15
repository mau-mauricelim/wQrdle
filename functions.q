/ https://code.kx.com/phrases/math/#permutations
/ distinct permutation function
perm:{distinct(1 0#x){raze(1 rotate)scan'x,'y}/x}
/ regex type solver
f:{[guess;place]
    bools:place=/:til 3;
    / possible position for 1 - can go to another 1 or 0
    wrongpos:guess where bool1:bools 1;
    pad:sum[bool0:bools 0]#"?";
    / get possible permutations of positions 0 and 1
    perms:perm wrongpos,pad;
    / filter permutations
    wnb2:where not bool2:bools 2;
    / original positions for 0 and 1 will be filtered out
    perms:perms where not{any@[y;z]=x}[;guess;wnb2]each perms;
    / create regex
    regexcl:"[^",guess[where bool0],"]";
    / additional exclusion for positions 1
    regexclpos1:((-1_regexcl),/:enlist each wrongpos),\:"]";
    regexs:{[perms;place;regexclpos1;wnb2;guess;regexcl]
        pos:w where b:"?"=perms w:where 1=place except 2;
        r:@[enlist each perms;pos;:;regexclpos1 where b];
        r:@[enlist each guess;wnb2;:;r];
        ssr[raze r;"?";regexcl]}[;place;regexclpos1;wnb2;guess;regexcl]each perms;
    / display remaining words
    0N!`;
    0N!`$"Possible words by frequency: ";
    `words_5_by_freq set 0N!words_5_by_freq where max words_5_by_freq like/:regexs;}