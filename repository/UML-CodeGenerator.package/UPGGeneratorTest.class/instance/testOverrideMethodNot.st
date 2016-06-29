tests
testOverrideMethodNot
	model := FAMIXMethod named: 'something'.
	cls compile: 'something "unchanged content"'.
	generator context doNotOverrideMethods.
	generator createMethodFor: model in: cls.
	self
		assert: (cls >> #something) ast
		equals: (RBParser parseMethod: 'something "unchanged content"')