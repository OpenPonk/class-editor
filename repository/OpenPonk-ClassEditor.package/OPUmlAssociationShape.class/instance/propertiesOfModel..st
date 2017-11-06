initialization
propertiesOfModel: aModel
	| props |
	props := OrderedCollection new.
	aModel appliedStereotypes
		do: [ :stereo | 
			| meta |
			meta := stereo umlMetaClass.
			meta ownedAttributes reject: [ :attr | attr name beginsWith: 'base_' ]
				thenDo: [ :attr | 
					(stereo perform: attr name asSymbol)
						ifNotNil: [ :value | 
							value = true
								ifTrue: [ props add: attr name ]
								ifFalse: [ value = false
										ifFalse: [ props add: attr name , '=' , attr value asString ] ] ] ] ].
	^ props