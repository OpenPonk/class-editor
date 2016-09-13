as yet unclassified
testSuperClassFor3
	| cls |
	cls := FAMIXClass named: 'Hello'.
	cls addStereotype: (DCFAMIXStereotype named: 'Entity').
	self assert: (exporter superClassFor: cls) equals: 'CormasNS.Kernel.Entity'