as yet unclassified
mergeClass: aClass
	self extractDefaultValue: aClass.
	self removeDefaultValueMethods: aClass.
	self removeMetaMethods: aClass.
	({aClass} , aClass superclassHierarchy flatCollect: #attributes)
		do: [ :each | self mergeAttribute: each in: aClass ].
	shouldMergeInheritances = true
		ifTrue: [ self replaceSuperclassWithStereotype: aClass ]