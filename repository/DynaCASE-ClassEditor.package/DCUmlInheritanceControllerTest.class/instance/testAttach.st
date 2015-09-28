tests
testAttach
	| inheritance ic |
	inheritance := FAMIXInheritance subclass: child superclass: parent.
	ic := DCUmlInheritanceController new.
	ic model: inheritance.
	self assert: (parentController canBeTargetFor: ic).
	self assert: (childController canBeSourceFor: ic).
	childController addAsSourceFor: ic.
	parentController addAsTargetFor: ic.
	self assert: diagramController controllers size equals: 3.
	self assert: diagramController controllers last equals: ic.
	self assert: diagramController model allInheritanceDefinitions first equals: inheritance