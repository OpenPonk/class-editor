tests
testAssociationNs
	super testAssociationNs.
	self assert: result source name equals: '::Object'.
	self assert: result target name equals: 'NS::Object'