utilities
defaultValueExpressionFor: anEntity
	(anEntity isAttribute and: [ anEntity defaultValue isNotNil ])
		ifTrue: [ ^ anEntity defaultValue valueExpression ].
	anEntity multiplicity upper > 1
		ifTrue: [ ^ 'OrderedCollection new' ].
	^ nil