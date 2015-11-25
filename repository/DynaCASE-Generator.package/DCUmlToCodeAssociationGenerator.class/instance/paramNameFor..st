utilities
paramNameFor: anAssociationEnd
	anAssociationEnd multiplicity upper > 1
		ifTrue: [ ^ 'aCollection' ].
	^ anAssociationEnd name first isVowel
		ifTrue: [ 'an' ]
		ifFalse: [ 'a' ] , anAssociationEnd name