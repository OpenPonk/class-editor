as yet unclassified
testEnsuring2
	| name attr meth |
	name := class figures first.
	meth := class ensureMethodsBox.
	self assert: (RTGroup with: name with: meth) equals: class figures.
	attr := class ensureAttributesBox.
	self assert: (RTGroup with: name with: attr with: meth) equals: class figures