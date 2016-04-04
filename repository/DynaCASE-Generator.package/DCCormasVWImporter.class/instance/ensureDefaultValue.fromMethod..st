as yet unclassified
ensureDefaultValue: aValue fromMethod: aMethod
	| attr value |
	value := aValue.
	(value isMemberOf: RBMessageNode)
		ifTrue: [ value := value receiver name asClass ].
	attr := aMethod parentType attributes
		detect: [ :each | each name = (aMethod name withoutSuffix: '_default') ]
		ifNone: [ | a |
			a := FAMIXAttribute new.
			a name: (aMethod name withoutSuffix: '_default').
			a isStatic: aMethod isStatic.
			aMethod mooseModel add: a.
			aMethod parentType attributes add: a.
			a ].
	attr declaredType: (FAMIXClass named: (self genericTypeFor: value)).
	attr defaultValue: (DCFAMIXValueSpecification from: value asString)