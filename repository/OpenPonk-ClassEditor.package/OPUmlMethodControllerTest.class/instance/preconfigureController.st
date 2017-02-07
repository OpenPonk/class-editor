running
preconfigureController
	| class |
	class := FAMIXClass named: 'Something'.
	class addMethod: (FAMIXMethod named: 'method').
	diagramController model add: class.
	diagramController rebuild.
	controller := diagramController controllers last