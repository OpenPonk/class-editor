tests
testMethod2
	self
		export: (self parseMethod: 'funct:ion:(a : Object, b : String[1..1]) : Result[0..*]')
		equals: 'funct:ion:(a, b : String) : Result[*]'