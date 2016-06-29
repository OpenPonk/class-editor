generator - model
generateFromModel: aModel
	self context shouldShowProgressBar
		ifTrue: [ ^ self generateWithProgressBar: aModel ].
	(self sortedHierarchyFor: aModel allModelClasses)
		do: [ :each | self createFullClassFor: each ].
	aModel allBinaryAssociations do: [ :each | self createAssociationFor: each ]