tests
testInitializeNoDuplicates
	generator addToInitialize: '1 + 1' in: cls.
	generator addToInitialize: '1 + 1' in: cls.
	self
		assert: (cls >> #initialize) ast
		equals: (RBParser parseMethod: 'initialize super initialize. 1 + 1')