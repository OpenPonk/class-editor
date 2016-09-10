transforming - accessors
lazyGetterSourceFor: anAttribute
	^ FAMIXSourceTextAnchor new
		source:
			('{1}
	^ {1} ifNil: [ {1} := {3} ]'
				format:
					{anAttribute name.
					self getterPragmaFor: anAttribute.
					anAttribute defaultValue valueExpression})