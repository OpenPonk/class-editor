tests
testInheritance
	self export: (self parseInheritance: 'Child >> Parent;') equals: 'Child >> Parent;'