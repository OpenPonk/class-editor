visitor
visitOwnedParameter: anElement
	elements
		at: anElement xmiId
		put: [ | param typeId |
			(param := FAMIXParameter new) name: anElement @ #name.
			typeId := anElement @ #type.
			typeId
				ifNotEmpty: [ elements
						at: typeId
						ifAbsentPut: [ FAMIXClass named: (self primitiveTypeForName: typeId) ].
					param declaredType: (self elementAt: typeId) ].
			anElement @ #direction
				ifNotEmpty: [ :dir | param direction: (OPUmlParameterDirectionKind valueAt: dir) ].
			(self elementAt: anElement parent xmiId) addParameter: param.
			param ].
	self visitChildren: anElement