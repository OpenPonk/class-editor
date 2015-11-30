tests
testCreateEmptyClass
	| name |
	name := #SomethingGenerated2.
	model := FAMIXClass named: name.
	self deny: (Smalltalk globals includesKey: name).
	cls := generator createClassFor: model.
	self assert: (Smalltalk globals includesKey: name).
	self assert: cls name equals: name.
	self assert: cls instVarNames equals: #().
	self assert: cls superclass equals: Object