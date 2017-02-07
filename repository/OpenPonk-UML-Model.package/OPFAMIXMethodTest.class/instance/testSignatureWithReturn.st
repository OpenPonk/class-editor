tests
testSignatureWithReturn
	(method := FAMIXMethod named: 'op')
		addParameter: (FAMIXParameter named: 'first' type: (FAMIXClass named: 'String'));
		addParameter:
			((FAMIXParameter named: 'return' type: (FAMIXClass named: 'Integer'))
				direction: OPUmlParameterDirectionKind return).
	self assert: method umlSignature equals: 'op(first : String) : Integer'