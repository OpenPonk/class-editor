visitor
visitEACustomProfile: anElement
	elements
		at: anElement
		put: [ | owner |
			owner := nil.
			anElement @ #base_Class ifNotEmpty: [ :ref | owner := ref ].
			anElement @ #base_EnumerationLiteral ifNotEmpty: [ :ref | owner := ref ].
			(self elementAt: owner) addStereotype: (OPFAMIXStereotype named: (anElement name splitOn: ':') last) ]