as yet unclassified
replaceSuperclassWithStereotype: aClass
	| parent corePkg |
	corePkg := #'Cormas-Core'.
	"Do not merge classes from core"
	aClass parentPackage name = corePkg
		ifTrue: [ ^ self ].
	parent := aClass superclass.
	parent ifNil: [ ^ self ].
	"Do not merge classes within the model itself"
	parent parentPackage name = corePkg
		ifFalse: [ ^ self ].
	aClass mooseModel remove: aClass superInheritances first.
	aClass superInheritances remove: aClass superInheritances first.
	aClass addStereotype: (DCFAMIXStereotype named: parent name)