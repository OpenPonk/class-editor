tests
testSignature
	(method := FAMIXMethod named: 'op')
		addParameter: (FAMIXParameter named: 'first' type: (FAMIXClass named: 'String')).
	self assert: method umlSignature equals: 'op(first : String)'