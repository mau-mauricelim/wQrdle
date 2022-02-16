# wQrdle solver

Wordle solver using kdb+/q

## Requirements

- kdb+

## Getting started

Start the wordle solver using:

```bash
$ q wordle_solver.q
```

## Demo
```q
...
`Enter your first guess:
q)"crane"
`
`"crane" has been entered.
`Enter the result for "crane":
q)1 0 2 0 1
`
`Possible words by frequency:
`beach`exact`teach`emacs`peach`leach`epact`ecads
`
`Enter your next guess:
q)
```

## Error handling
```q
`Enter your next guess:
q)beach
`
`Only char type (10h) is allowed for the guess. Enter your guess again:
q)"abcde"
`
`Guess is not allowed. Try another guess:
q)"abc"
`
`Please enter a 5-letter word guess:
q)"beach"
`
`"beach" has been entered.
`Enter the result for "beach":
q)1
`
`Only long type (7h) is allowed for the result. Enter the result for "beach" again:
q)1 2
`
`The result must be a list of length 5. Enter the result for "beach" again:
q)1 2 3 4 5
`
`All result items must be within 0 and 2. Enter the result for "beach" again:
q)0 1 2 2 0
`
`Possible words by frequency:
`exact`emacs`epact
`
`Enter your next guess:
q)
```