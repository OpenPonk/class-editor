visitor
visitType: anElement
	elements
		at: anElement
		put: [ | typeId |
			typeId := anElement @ #xmi:idref.
			elements
				at: typeId
				ifAbsent: [ elements at: typeId put: (FAMIXClass named: (self primitiveTypeFor: anElement)) ].
			(self elementAt: anElement parent xmiId)
				declaredType: (self elementAt: anElement @ #xmi:idref).
			nil ]