tests
testOverrideMethod
	model := FAMIXMethod named: 'something'.
	cls compile: 'something "some content"'.
	generator overrideMethods.
	generator createMethodFor: model in: cls.
	self
		assert: (cls >> #something) ast
		equals: (RBParser parseMethod: 'something <DCMethod: ''something()''> "not yet implemented"')