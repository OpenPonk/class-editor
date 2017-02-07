tests-accessing
testModelTypes
	self
		assert: (provider modelTypes collect: #name)
		equals: #()