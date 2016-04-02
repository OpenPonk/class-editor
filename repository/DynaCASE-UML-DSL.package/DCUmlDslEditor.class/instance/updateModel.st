event handling
updateModel
	| statements text |
	model ifNil: [ model := MooseModel new ].
	text := editor text.
	text makeAllColor: Smalltalk ui theme textColor.
	statements := parser parseStatements: text asString.
	statements isPetitFailure
		ifTrue: [ text asPetitStream newlines
				overlappingPairsDo: [ :start :end | 
					(statements position between: start and: end)
						ifTrue: [ text makeColor: Color red from: start to: end ] ] ]
		ifFalse: [ parser replaceModel: model withStatements: statements ].
	editor text: text.
	model announcer announce: (DCModelContentReplaced model: model)