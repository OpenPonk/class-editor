generator - model
generateFromModel: aModel
	self context shouldShowProgressBar
		ifTrue: [ ^ self generateWithProgressBar: aModel ].
	(self allModelClasses asSortedCollection: [ :a :b | a superclassHierarchy includes: b ])
		reversed do: [ :each | self createFullClassFor: each ].
	aModel allBinaryAssociations do: [ :each | self createAssociationFor: each ]