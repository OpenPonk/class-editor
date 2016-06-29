utilities
paramNameForType: aType
	^ (aType name first isVowel
		ifTrue: [ 'an' ]
		ifFalse: [ 'a' ]) , aType name