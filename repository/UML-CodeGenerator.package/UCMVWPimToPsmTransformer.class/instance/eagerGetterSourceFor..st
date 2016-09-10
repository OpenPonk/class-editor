transforming - accessors
eagerGetterSourceFor: anAttribute
	^ DCUmlSingleOpaqueBehavior
		body:
			('{1}
	^ {1}'
				format:
					{anAttribute name.
					self getterPragmaFor: anAttribute})