tests
testVisibility
	OPUmlVisibilityKind symbolMapping
		keysAndValuesDo: [ :symbol :literal | 
			self parse: symbol asString rule: #visibility.
			self assert: result equals: literal ].
	self fail: '*' rule: #visibility