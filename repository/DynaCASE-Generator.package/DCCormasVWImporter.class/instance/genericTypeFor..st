as yet unclassified
genericTypeFor: aValue
	aValue isInteger
		ifTrue: [ ^ 'Integer' ].
	aValue isFloat
		ifTrue: [ ^ 'Float' ].
	aValue isString
		ifTrue: [ ^ 'String' ]