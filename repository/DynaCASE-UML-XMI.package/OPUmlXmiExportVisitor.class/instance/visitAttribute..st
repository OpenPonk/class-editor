visitor
visitAttribute: anAttribute
	| attrs |
	attrs := Dictionary
		with: #xmi:type -> 'uml:Property'
		with: #xmi:id -> anAttribute uuid asString
		with: #name -> anAttribute name.
	anAttribute isAbstract
		ifTrue: [ attrs at: #isAbstract put: true asString ].
	anAttribute isStatic
		ifTrue: [ attrs at: #isStatic put: true asString ].
	writer
		tag: #ownedAttribute
		attributes: attrs
		with: [ self visitType: anAttribute declaredType.
			self visitMultiplicity: anAttribute multiplicity.
			self visitDefaultValue: anAttribute defaultValue ]