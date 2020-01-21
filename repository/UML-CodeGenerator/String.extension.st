Extension { #name : #String }

{ #category : #'*UML-CodeGenerator' }
String >> asEnglishSingular [
	"Answer the singular of the receiver.  Assumes the receiver is an English noun.
	For a more comprehensive algorithm please refer to ''An Algorithmic Approach
	to English Pluralization'' by Damian Conway."

	self size < 2
		ifTrue: [ ^ self ].
	self asString = 'children'
		ifTrue: [ ^ 'child' ].
	(self endsWith: 'ies')
		ifTrue: [ ^ self replaceSuffix: 'ies' with: 'y' ].
	(self endsWith: 'ses')
		ifTrue: [ ^ self replaceSuffix: 'ses' with: 's' ].
	^ self removeSuffix: 's'
]
