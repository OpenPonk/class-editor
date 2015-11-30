generator - class
createClassFor: aFamixClass
	| parentName |
	parentName := aFamixClass superInheritances
		ifEmpty: [ 'Object' ]
		ifNotEmpty: [ :supers | supers first superclass name ].
	^ parentName asClass
		subclass: aFamixClass name
		instanceVariableNames: ''
		classVariableNames: ''
		category: self context category