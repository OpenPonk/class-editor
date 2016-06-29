generator - class
createClassFor: aClass
	| parentName |
	(self isForeignClass: aClass)
		ifTrue: [ ^ aClass smalltalkClass ].
	parentName := aClass superInheritances
		ifEmpty: [ 'Object' ]
		ifNotEmpty: [ :supers | supers first superclass name ].
	aClass stereotypes ifNotEmpty: [ :s | parentName := s first name ].
	^ parentName asClass
		subclass: aClass name
		instanceVariableNames: ''
		classVariableNames: ''
		category: self context package