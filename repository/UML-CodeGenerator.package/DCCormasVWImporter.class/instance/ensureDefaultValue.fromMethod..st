as yet unclassified
ensureDefaultValue: aValue fromMethod: aMethod
	| attr |
	attr := aMethod parentType attributes
		detect: [ :each | each name = (aMethod name withoutSuffix: '_default') ]
		ifNone: [ | a |
			a := FAMIXAttribute new.
			a name: (aMethod name withoutSuffix: '_default').
			a isStatic: aMethod isStatic.
			aMethod mooseModel add: a.
			aMethod parentType attributes add: a.
			a ].
	attr declaredType: (FAMIXClass named: (self genericTypeFor: aValue)).
	attr
		defaultValue: (DCFAMIXValueSpecification from: (self stringSpecificationFor: aValue))