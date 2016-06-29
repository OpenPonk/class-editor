generator - method
addEagerValueFor: anEntity in: aClass
	| expression |
	expression := self defaultValueExpressionFor: anEntity.
	expression ifNil: [ ^ self ].
	self
		addToInitialize: ('{1} := {2}' format: (Array with: anEntity name with: expression))
		in: aClass