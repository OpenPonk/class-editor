ui hooks
createClassFor: aModelClass
	(RBAddClassRefactoring
		addClass: aModelClass name
		superclass: Object
		subclasses: #()
		category: aModelClass mooseModel name asSymbol) execute