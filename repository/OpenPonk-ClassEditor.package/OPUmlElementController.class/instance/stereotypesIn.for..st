as yet unclassified
stereotypesIn: aProfile for: aModel
	^ aProfile ownedStereotype
		select: [ :stereo | 
			stereo ownedAttributes
				anySatisfy:
					[ :each | (each name beginsWith: 'base_') and: [ self model oclIsKindOf: each type umlClassName ] ] ]