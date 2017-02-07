instance creation
newCompleteClass
	| class |
	class := FAMIXClass named: 'Something'.
	class addAttribute: (FAMIXAttribute named: 'attribute').
	class addMethod: (FAMIXMethod named: 'operation').
	^ class