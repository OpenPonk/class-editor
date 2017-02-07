tests
testSignature
	parameter := FAMIXParameter named: 'name' type: (FAMIXClass named: 'String').
	self assert: parameter umlSignature equals: 'name : String'