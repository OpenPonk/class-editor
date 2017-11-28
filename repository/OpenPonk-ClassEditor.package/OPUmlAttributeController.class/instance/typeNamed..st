accessing
typeNamed: aName
	OPUMLXMISpecsStorage primitivesMap at: aName ifPresent: [ :prim | ^ prim ].
	(diagramController model packagedElements select: [ :each | each oclIsKindOf: #Type ])
		detect: [ :each | each name = aName ]
		ifFound: [ :type | ^ type ].
	^ OPUMLClass new name: aName