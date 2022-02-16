# wQrdle solver

Wordle solver using kdb+/q

## Requirements

- kdb+

## Getting started

Start the wordle solver using:

```bash
$ q wordle_solver.q
```

## Usage

The solver can be restarted in 2 ways:
- Entering `2 2 2 2 2` in the input result prompt
- Entering `` `restart`` in the q prompt

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
...
`Enter your first guess:
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
`u#`place`space`exact`grace`trace`emacs`enact`glace`apace`epact
`
`Enter your next guess:
q)"beach"
`
`Guess is not allowed. Try another guess:
q)"place"
`
`"place" has been entered.
`Enter the result for "place":
q)1 1 1 1 1
`
`There are no possible words that match the given result.
`
`Possible words by frequency:
`u#`place`space`exact`grace`trace`emacs`enact`glace`apace`epact
`
`Enter the result for "place" again:
q)
```