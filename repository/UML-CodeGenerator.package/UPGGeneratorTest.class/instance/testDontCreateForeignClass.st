tests
testDontCreateForeignClass
	model := FAMIXClass named: #UPGTestForeign.
	self assert: model smalltalkClass superclass equals: String.
	self deny: model smalltalkClass package name = generator context package.
	self assert: model smalltalkClass instVarNames asArray equals: #(someVar).
	self assert: (generator createClassFor: model) equals: model smalltalkClass.
	self assert: model smalltalkClass superclass equals: String.
	self deny: model smalltalkClass package name = generator context package.
	self assert: model smalltalkClass instVarNames asArray equals: #(someVar)