instance creation
newClassNamed: aName inCategory: aCategory
	| klass |
	klass := Object
		subclass: aName
		instanceVariableNames: ''
		classVariableNames: ''
		poolDictionaries: ''
		category: aCategory.
	^ klass