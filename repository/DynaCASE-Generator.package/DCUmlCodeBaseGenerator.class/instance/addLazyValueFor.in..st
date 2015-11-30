generator - method
addLazyValueFor: anAttribute in: aClass
	| expression |
	expression := self defaultValueExpressionFor: anAttribute.
	expression ifNil: [ ^ self ].
	aClass
		compile:
			('{name}
	{pragma}
	^ {name} ifNil: [ {name} := {value} ]'
				format:
					(Dictionary
						with: #name -> anAttribute name
						with: #pragma -> (self getterPragmaFor: anAttribute)
						with: #value -> expression))
		classified: 'accessing'