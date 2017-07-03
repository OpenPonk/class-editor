adding
addConstraintsTo: aCollection at: aPosition
	aCollection
		add: [ self constraintLabel: nameLabel at: aPosition side: 1.
			self constraintLabel: multiplicityLabel at: aPosition side: -1 ]