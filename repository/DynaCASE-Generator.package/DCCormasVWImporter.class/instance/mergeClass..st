as yet unclassified
mergeClass: aClass
	self extractDefaultValue: aClass.
	self removeDefaultValueMethods: aClass.
	self removeMetaMethods: aClass.
	self removeAccessors: aClass.
	(aClass superclassHierarchy flatCollect: #attributes)
		do: [ :each | self mergeAttribute: each ]