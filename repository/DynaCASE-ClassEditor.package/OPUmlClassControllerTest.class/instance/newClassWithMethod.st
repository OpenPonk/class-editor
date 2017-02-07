instance creation
newClassWithMethod
	| model class |
	model := MooseModel new.
	class := FAMIXClass named: 'Something'.
	model add: class.
	class addMethod: (FAMIXMethod named: 'method1').
	^ class