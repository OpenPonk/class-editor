as yet unclassified
testEnsuring1
	| name attr meth |
	name := class figures first.
	attr := class ensureAttributesBox.
	self assert: (RTGroup with: name with: attr) equals: class figures.
	meth := class ensureMethodsBox.
	self assert: (RTGroup with: name with: attr with: meth) equals: class figures