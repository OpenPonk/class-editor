tests
testMethodWithPragma
	cls
		compile:
			'add: aNumber to: anotherNumber
		<DCMethod: ''add:to:(aNumber : Float, anotherNumber : Integer) : Number''>
		^ aNumber + anotherNumber'.
	model := generator createMethodFor: #add:to: in: cls.
	self assert: model class equals: FAMIXMethod.
	self assert: model name equals: #add:to:.
	self assert: model declaredType name equals: #Number.
	self assert: model parameters size equals: 3.
	self assert: model parameters first class equals: FAMIXParameter.
	self assert: model parameters first name equals: #aNumber.
	self assert: model parameters first declaredType name equals: #Float.
	self assert: model parameters second class equals: FAMIXParameter.
	self assert: model parameters second name equals: #anotherNumber.
	self assert: model parameters second declaredType name equals: #Integer.
	self assert: model parameters third class equals: FAMIXParameter.
	self assert: model parameters third name equals: #return.
	self assert: model parameters third declaredType name equals: #Number.
	self assert: model parameters third direction equals: DCUmlParameterDirectionKind return