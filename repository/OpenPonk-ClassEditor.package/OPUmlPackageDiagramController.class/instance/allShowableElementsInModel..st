retrieving
allShowableElementsInModel: aModel
	| queue |
	queue := OrderedCollection new.
	queue addAll: aModel packagedElements.
	aModel packagedElements
		select: [ :each | each isKindOf: OPUMLClass ]
		thenDo: [ :each | 
			each generalizations
				do: [ :gen | 
					queue addIfNotPresent: gen general.
					queue add: gen ].
			(each ownedAttributes select: [ :attr | attr association isNotNil ])
				do: [ :attr | queue addIfNotPresent: attr association ] ].
	queue
		removeAllSuchThat: [ :each | 
			(each isKindOf: OPUMLAssociation)
				and:
					[ each memberEnds anySatisfy: [ :membEnd | (queue includes: membEnd type) not ] ] ].
	^ queue asArray select: [ :each | self hasSupportForModel: each ]