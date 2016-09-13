as yet unclassified
testSuperClassFor2
	| cls supCls |
	cls := FAMIXClass named: 'Hello'.
	supCls := FAMIXClass named: 'Super'.
	FAMIXInheritance subclass: cls superclass: supCls.
	self assert: (exporter superClassFor: cls) equals: 'CormasNS.Models.UnknownModel.Super'