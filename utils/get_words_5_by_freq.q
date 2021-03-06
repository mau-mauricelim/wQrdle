/
// Parsing data
/ https://www.kaggle.com/rtatman/english-word-frequency/version/1
/ english words by frequency
unigram_freq:("SJ";enlist",")0:`:../data/unigram_freq.csv
/ filter 5 letter words
words_5_by_freq:exec word from unigram_freq where 5=count each string word
/ list of wordle allowed words
allowed_words:`$read0`:../data/allowed_words.txt
/ get the intersection of words with frequency and allowed words
/ then union to combine the remaining allowed words with no frequency data
/ save to disk
`:../data/words_5_by_freq set`u#(words_5_by_freq inter allowed_words)union allowed_words
\

/ load the data from root
words_5_by_freq_orig:words_5_by_freq:get`:data/words_5_by_freq