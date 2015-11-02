tests
testCreateEmptyClass
	| model |
	model := FAMIXClass named: 'SomethingGenerated'.
	self deny: (Smalltalk globals includesKey: #SomethingGenerated).
	cls := generator createClassFor: model.
	self assert: (Smalltalk globals includesKey: #SomethingGenerated).
	self assert: cls name equals: 'SomethingGenerated'.
	self assert: cls instVarNames equals: #().
	self assert: cls superclass equals: Object