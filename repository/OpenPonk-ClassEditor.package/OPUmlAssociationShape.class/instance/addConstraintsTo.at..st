configuration
addConstraintsTo: aCollection at: aPosition
	aCollection add: (self constraintLabel: nameLabel at: aPosition side: -1).
	aCollection add: (self constraintLabel: stereotypeLabel at: aPosition side: 1).