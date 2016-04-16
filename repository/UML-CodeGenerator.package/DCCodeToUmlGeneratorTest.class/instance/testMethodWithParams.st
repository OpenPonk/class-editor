tests
testMethodWithParams
	cls compile: 'add: aNumber to: anotherNumber ^ aNumber + anotherNumber'.
	model := generator createMethodFor: #add:to: in: cls.
	self assert: model class equals: FAMIXMethod.
	self assert: model name equals: #add:to:.
	self assert: model parameters size equals: 2.
	self assert: model parameters first class equals: FAMIXParameter.
	self assert: model parameters first name equals: #aNumber.
	self assert: model parameters second class equals: FAMIXParameter.
	self assert: model parameters second name equals: #anotherNumber