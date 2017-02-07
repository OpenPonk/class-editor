tests
testAssociationNs1
	super testAssociationNs1.
	self assert: result source name equals: 'NS::Object'.
	self assert: result target name equals: '::Object'