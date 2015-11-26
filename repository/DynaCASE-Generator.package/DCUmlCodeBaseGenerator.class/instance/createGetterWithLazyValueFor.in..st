generator - method
createGetterWithLazyValueFor: anAttribute in: aClass
	aClass
		compile:
			('{name}
	{pragma}
	^ {name} ifNil: [ {name} := {value} ]'
				format:
					(Dictionary
						with: #name -> anAttribute name
						with: #pragma -> (self getterPragmaFor: anAttribute)
						with: #value -> anAttribute defaultValue valueExpression))
		classified: 'accessing'