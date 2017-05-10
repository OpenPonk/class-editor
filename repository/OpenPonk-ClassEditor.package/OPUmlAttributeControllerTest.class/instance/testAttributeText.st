tests
testAttributeText
	self
		assert:
			(controller
				attributeTextFor:
					(OPUMLProperty new
						name: 'attr';
						isDerived: true))
		equals: '/attr'