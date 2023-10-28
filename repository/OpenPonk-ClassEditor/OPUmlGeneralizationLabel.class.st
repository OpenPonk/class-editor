Class {
	#name : #OPUmlGeneralizationLabel,
	#superclass : #OPUmlEdgeLabel,
	#category : #'OpenPonk-ClassEditor-Shapes'
}

{ #category : #'as yet unclassified' }
OPUmlGeneralizationLabel >> defaultAnchorConstraintPosition [

	^ OPRSAnchorConstraintBalanceReference balance: 0.5
]

{ #category : #accessing }
OPUmlGeneralizationLabel >> defaultText [

	| labels |
	labels := (self modelElement generalizationSets ifEmpty: [ ^ '' ]) 
		          collect: [ :each | 
			          String streamContents: [ :stream | 
				          | props |
				          (each name isNotNil and: [ each name isNotEmpty ]) 
					          ifTrue: [ 
						          stream
							          << each name;
							          << ' ' ].
				          props := OrderedCollection new.
				          each isCovering ifTrue: [ props add: 'complete' ].
				          each isCovering not & self showIncomplete ifTrue: [ 
					          props add: 'incomplete' ].
				          each isDisjoint ifTrue: [ props add: 'disjoint' ].
				          each isDisjoint not & self showOverlapping ifTrue: [ 
					          props add: 'overlapping' ].
				          props ifNotEmpty: [ 
					          stream << '{'.
					          props
						          do: [ :p | stream << p ]
						          separatedBy: [ stream << ', ' ].
					          stream << '}' ] ] ].
	^ labels joinUsing: String cr
]

{ #category : #testing }
OPUmlGeneralizationLabel >> showIncomplete [

	^ false
]

{ #category : #testing }
OPUmlGeneralizationLabel >> showOverlapping [

	^ false
]
