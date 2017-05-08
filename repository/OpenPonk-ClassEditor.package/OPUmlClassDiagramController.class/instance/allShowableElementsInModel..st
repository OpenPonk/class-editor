retrieving
allShowableElementsInModel: aModel
	| queue |
	queue := OrderedCollection new.
	queue addAll: aModel packagedElements.
	aModel packagedElements
		select: [ :each | each isKindOf: OPUMLClass ]
		thenDo: [ :each | 
			queue addAll: each attributes.
			queue addAll: each ownedOperations.
			queue addAll: each ownedComments.
			each generalizations
				do: [ :gen | 
					queue addIfNotPresent: gen general.
					queue add: gen ].
			(each attributes select: [ :attr | attr association isNotNil ])
				do: [ :attr | queue addIfNotPresent: attr association ] ].
	^ queue asArray select: [ :each | self hasSupportForModel: each ]