transforming - accessors
lazyGetterSourceFor: anAttribute
	^ OPUmlSingleOpaqueBehavior
		body:
			('{1}
	^ {1} ifNil: [ {1} := {3} ]'
				format:
					{anAttribute name.
					self getterPragmaFor: anAttribute.
					anAttribute defaultValue valueExpression})