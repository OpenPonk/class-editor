running
preconfigureController
	| class |
	class := FAMIXClass named: 'Something'.
	class addAttribute: (FAMIXAttribute named: 'attr').
	diagramController model add: class.
	diagramController rebuild.
	controller := diagramController controllers last