generator - model
generateFromModel: aModel
	self context shouldShowProgressBar
		ifTrue: [ ^ self generateWithProgressBar: aModel ].
	(aModel allClasses
		sorted: [ :a :b | (b superInheritances collect: #superclass) includes: a ])
		do: [ :each | self createFullClassFor: each ].
	aModel allBinaryAssociations do: [ :each | self createAssociationFor: each ]