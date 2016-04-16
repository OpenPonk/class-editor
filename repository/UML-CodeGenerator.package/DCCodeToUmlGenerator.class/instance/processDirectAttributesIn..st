as yet unclassified
processDirectAttributesIn: aClass
	aClass attributes
		do: [ :attr | 
			aClass methods
				detect: [ :method | method name = attr name ]
				ifFound: [ :getter | 
					getter compiledMethod pragmas
						detect: [ :each | each keyword = #DCType:multiplicity: ]
						ifFound: [ :pragma | 
							attr
								declaredType:
									(aClass mooseModel allModelClasses
										detect: [ :cls | cls name = pragma arguments first ]
										ifFound: [ :cls | cls ]
										ifNone: [ FAMIXClass named: pragma arguments first ]).
							attr
								multiplicity: (DCFAMIXMultiplicity fromArray: pragma arguments second).
							getter removeFromModel.
							aClass methods remove: getter.
							(Array
								with: attr name , ':'
								with: 'add' , attr name capitalized , ':'
								with: 'remove' , attr name capitalized , ':')
								do: [ :extraMethod | 
									aClass methods
										detect: [ :method | method name = extraMethod ]
										ifFound: [ :method | 
											method removeFromModel.
											aClass methods remove: method ] ] ] ] ]