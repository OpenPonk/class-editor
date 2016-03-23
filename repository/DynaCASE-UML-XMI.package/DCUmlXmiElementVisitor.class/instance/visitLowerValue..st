visitor
visitLowerValue: anElement
	elements
		at: anElement
		put: [ | num |
			num := (anElement @ #value) asNumber.
			(self elementAt: anElement parent xmiId) multiplicity
				lowerValue:
					(num = -1
						ifTrue: [ 0 ]
						ifFalse: [ num ]).
			nil ]