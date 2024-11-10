Class {
	#name : 'OPUmlGeneralizationLabel',
	#superclass : 'OPUmlEdgeLabel',
	#category : 'OpenPonk-ClassEditor-Shapes',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Shapes'
}

{ #category : 'as yet unclassified' }
OPUmlGeneralizationLabel >> defaultAnchorConstraintPosition [

	^ OPRSAnchorConstraintBalanceReference balance: 0.5
]

{ #category : 'accessing' }
OPUmlGeneralizationLabel >> defaultText [

	^ String streamContents: [ :s |
		  self modelElement generalizationSets
			  do: [ :each | self defaultTextForSet: each on: s ]
			  separatedBy: [ s << '; ' ] ]
]

{ #category : 'accessing' }
OPUmlGeneralizationLabel >> defaultTextForSet: aGeneralizationSet on: aStream [

	| props |
	aStream << (aGeneralizationSet name trim ifEmpty: [ 'set' ]).

	aStream << ' {'.
	props := OrderedCollection new.
	aGeneralizationSet isCovering ifTrue: [ props add: 'complete' ].
	aGeneralizationSet isDisjoint ifTrue: [ props add: 'disjoint' ].
	props do: [ :p | aStream << p ] separatedBy: [ aStream << ', ' ].
	aStream << '}'
]

{ #category : 'testing' }
OPUmlGeneralizationLabel >> showIncomplete [

	^ false
]

{ #category : 'testing' }
OPUmlGeneralizationLabel >> showOverlapping [

	^ false
]
