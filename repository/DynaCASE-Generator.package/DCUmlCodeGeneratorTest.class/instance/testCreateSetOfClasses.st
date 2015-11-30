tests
testCreateSetOfClasses
	| parentModel childModel classes |
	parentModel := FAMIXClass named: 'GeneratorParent'.
	childModel := FAMIXClass named: 'GeneratorChild'.
	FAMIXInheritance subclass: childModel superclass: parentModel.
	classes := generator createClassesFor: (Array with: childModel with: parentModel).
	self assert: classes size equals: 2.
	self assert: classes first name equals: parentModel name.
	self assert: classes second name equals: childModel name.
	self assert: classes second superclass equals: classes first