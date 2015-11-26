generator - attribute
createAttributeFor: aFamixAttribute in: aClass
	| cls |
	cls := aClass.
	aFamixAttribute isStatic
		ifTrue: [ cls := cls class ].
	((cls withAllSuperclasses flatCollect: #instVarNames) includes: aFamixAttribute name)
		ifFalse:
			[ cls addInstVarNamed: aFamixAttribute name.
			generateAccessors
				ifTrue: [ self createAccessorsFor: aFamixAttribute in: cls ] ].
	self specifyDefaultValueFor: aFamixAttribute in: cls