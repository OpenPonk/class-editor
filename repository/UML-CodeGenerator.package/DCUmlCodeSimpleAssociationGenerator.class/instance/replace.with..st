utilities
replace: aString with: anArray
	| newString |
	newString := aString.
	anArray do: [ :each | newString := newString copyReplaceAll: each key with: each value ].
	^ newString