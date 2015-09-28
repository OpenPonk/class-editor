instance creation
newSimpleInheritance
	| parent child inheritance |
	parent := FAMIXClass named: 'parent'.
	child := FAMIXClass named: 'child'.
	inheritance := FAMIXInheritance superclass: parent subclass: child.
	^ inheritance