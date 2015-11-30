tests
testCreateSubclassClass
	| parentModel childModel parentCls childCls |
	parentModel := FAMIXClass named: 'GeneratorParent'.
	childModel := FAMIXClass named: 'GeneratorChild'.
	FAMIXInheritance subclass: childModel superclass: parentModel.
	parentCls := generator createClassFor: parentModel.
	childCls := generator createClassFor: childModel.
	self assert: parentCls name equals: parentModel name.
	self assert: childCls name equals: childModel name.
	self assert: childCls superclass equals: parentCls.
	parentCls removeFromSystem.
	childCls removeFromSystem