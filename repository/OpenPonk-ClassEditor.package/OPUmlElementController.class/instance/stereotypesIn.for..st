as yet unclassified
stereotypesIn: aProfile for: aModel
	^ (aProfile ownedStereotype reject: #isAbstract)
		select: [ :stereo | 
			stereo allAttributes
				anySatisfy: [ :each | (each name beginsWith: 'base_') and: [ self model oclIsKindOf: each type name ] ] ]