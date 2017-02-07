tests-accessing
testCollectionTypes
	self
		assert: (provider collectionTypes collect: #name)
		equals: #(Collection OrderedCollection Set Dictionary Array)