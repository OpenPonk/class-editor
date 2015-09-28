tests
testBuild
	| inheritance |
	inheritance := FAMIXInheritance superclass: parent subclass: child.
	diagramController model add: inheritance.
	diagramController rebuild.
	self assert: diagramController controllers size equals: 3.
	self
		assertCollection: (diagramController controllers collect: #model)
		hasSameElements:
			{inheritance.
			inheritance superclass.
			inheritance subclass}