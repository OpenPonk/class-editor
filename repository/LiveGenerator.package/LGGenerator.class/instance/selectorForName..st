as yet unclassified
selectorForName: aString
	"selector must adhere to /^[a-z][a-zA-Z0-9_]*$/"

	| selector |
	selector := aString copyWithRegex: '[^a-zA-Z0-9_]' matchesReplacedWith: '_'.
	selector first isLetter
		ifFalse: [ selector := 'get' , selector capitalized ].
	^ selector uncapitalized asSymbol