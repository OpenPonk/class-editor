utilities
typeNameForEnd: anEnd
	^ (anEnd property name first isVowel
		ifTrue: [ 'an' ]
		ifFalse: [ 'a' ]) , anEnd property name