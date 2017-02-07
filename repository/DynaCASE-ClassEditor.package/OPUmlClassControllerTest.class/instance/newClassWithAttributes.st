instance creation
newClassWithAttributes
	| class |
	class := FAMIXClass named: 'Something'.
	class addAttribute: (FAMIXAttribute named: 'attribute1').
	class addAttribute: (FAMIXAttribute named: 'attribute2').
	^ class