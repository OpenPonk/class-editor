tests
testEmptyClass
	cls := self newClassNamed: #SomethingEmpty.
	model := generator createClassFor: cls.
	self assert: model class equals: FAMIXClass.
	self assert: model name equals: #SomethingEmpty.
	self assert: model attributes isEmpty.
	self assert: model methods isEmpty.
	self assert: model associations isEmpty