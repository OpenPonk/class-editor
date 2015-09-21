tests
testMethodName
	| model name |
	model := FAMIXClass new.
	name := generator methodNameFor: model.
	self assert: name equals: 'Method'.
	model addMethod: (FAMIXMethod named: name).

	name := generator methodNameFor: model.
	self assert: name equals: 'Method1'