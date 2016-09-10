transforming
accessorsFor: anAttribute
	| accessors collection |
	self context shouldAddAccessors
		ifFalse: [ ^ #() ].
	accessors := Array
		with: (self getterFor: anAttribute)
		with: (self setterFor: anAttribute).
	collection := #().
	anAttribute isCollection
		ifTrue: [ collection := Array
				with: (self adderFor: anAttribute)
				with: (self removerFor: anAttribute) ].
	^ accessors , collection