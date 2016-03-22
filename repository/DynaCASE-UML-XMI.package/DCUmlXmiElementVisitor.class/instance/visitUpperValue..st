visitor
visitUpperValue: anElement
	elements
		at: anElement xmiId
		put: [ | mul |
			mul := (self elementAt: anElement parent xmiId) multiplicity.
			anElement @ #value = '*' | (anElement @ #value = '-1')
				ifTrue: [ mul upperValue beUnlimited ]
				ifFalse: [ mul upperValue value: (anElement @ #value) asNumber ].
			mul ]