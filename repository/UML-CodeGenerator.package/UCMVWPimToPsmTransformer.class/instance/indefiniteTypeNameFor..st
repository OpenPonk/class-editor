transforming - utility
indefiniteTypeNameFor: anEntity
	| prefix base |
	base := anEntity isCollection
		ifTrue: [ 'Collection' ]
		ifFalse: [ self typeNameFor: anEntity ].
	prefix := base first isVowel
		ifTrue: [ 'an' ]
		ifFalse: [ 'a' ].
	^ prefix , base