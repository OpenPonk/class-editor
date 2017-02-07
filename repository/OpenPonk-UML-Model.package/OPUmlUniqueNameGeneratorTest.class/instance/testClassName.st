tests
testClassName
	| model name |
	model := MooseModel new.
	name := generator classNameFor: model.
	self assert: name equals: 'Class'.
	model add: (FAMIXClass named: name).

	name := generator classNameFor: model.
	self assert: name equals: 'Class1'