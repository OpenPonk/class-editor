tests
testAssociation1
	self
		export:
			(self
				parseAssociation: 'University[1] university <*>-- departments Department[*] :  composition;')
		equals: 'University university <*>-- departments Department[*] : composition;'