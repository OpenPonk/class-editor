tests
testMethod1
	self export: (self parseMethod: 'funct:ion:(a, b)') equals: 'funct:ion:(a, b)'