generator - attribute
createAttributeFor: aFamixAttribute in: aClass
	| cls |
	cls := aClass.
	aFamixAttribute isStatic not
		ifTrue: [ cls addInstVarNamed: aFamixAttribute name ]
		ifFalse: [ cls addClassVarNamed: aFamixAttribute name.
			cls := cls class ].
	generateAccessors
		ifTrue: [ self createAccessorsFor: aFamixAttribute in: cls ].
	self specifyDefaultValueFor: aFamixAttribute in: cls