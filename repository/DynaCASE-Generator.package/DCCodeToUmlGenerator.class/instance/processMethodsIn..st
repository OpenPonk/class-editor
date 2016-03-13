as yet unclassified
processMethodsIn: aClass
	aClass methods
		select: [ :each | each name = 'initialize' ]
		thenDo: [ :each | 
			each removeFromModel.
			aClass methods remove: each ].
	aClass methods
		do: [ :each | 
			each compiledMethod pragmas
				detect: [ :pragma | pragma keyword = 'DCMethod:' ]
				ifFound: [ :pragma | 
					| parsed |
					parsed := DCUmlDSLFactory new method: pragma arguments first.
					each parameters: parsed parameters asArray.
					each declaredType: parsed declaredType.
					each multiplicity: parsed multiplicity ] ]