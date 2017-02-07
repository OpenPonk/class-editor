instance creation
operationWithParameter
	^ (FAMIXMethod named: 'op')
		addParameter: (FAMIXParameter named: 'arg' type: (FAMIXClass named: 'Object'));
		yourself