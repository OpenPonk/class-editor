visitor
visitLowerValue: anElement
	elements
		at: anElement
		put: [ | num |
			num := anElement @ #value.
			num := num ifEmpty: [ 1 ] ifNotEmpty: #asNumber.
			(self elementAt: anElement parent xmiId) multiplicity
				lowerValue:
					(num = -1
						ifTrue: [ 0 ]
						ifFalse: [ num ]).
			nil ]