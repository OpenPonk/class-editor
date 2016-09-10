tests
testCopyClassesFromTo
	input := MooseModel new.
	input add: (FAMIXClass named: 'Child').
	input add: (FAMIXClass named: 'Parent').
	input
		add: (FAMIXInheritance subclass: input allClasses first superclass: input allClasses second).
	result := MooseModel new.
	transformer copyClassesFrom: input to: result.
	self assert: result allClasses size equals: 2.
	self assert: result allClasses first name equals: input allClasses first name.
	self deny: result allClasses first = input allClasses first.
	self assert: result allInheritanceDefinitions size equals: 1.
	self
		deny: result allInheritanceDefinitions first = input allInheritanceDefinitions first