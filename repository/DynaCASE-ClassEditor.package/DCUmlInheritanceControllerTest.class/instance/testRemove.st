tests
testRemove
	| inheritance |
	inheritance := FAMIXInheritance superclass: parent subclass: child.
	diagramController model add: inheritance.
	diagramController rebuild.
	self assert: parent subInheritances size equals: 1.
	self assert: child superInheritances size equals: 1.
	diagramController removeFromModel: inheritance.
	self assert: parent subInheritances size equals: 0.
	self assert: child superInheritances size equals: 0.
	self assert: diagramController controllers size equals: 2.
	self assert: diagramController model allInheritanceDefinitions size equals: 0