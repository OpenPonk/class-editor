tests
testSuperClassFor
	| cls |
	cls := FAMIXClass named: 'Hello'.
	self assert: (exporter superClassFor: cls) equals: 'Core.Object'