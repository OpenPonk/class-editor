as yet unclassified
testEmpty
	self assert: class model equals: nil.

	self assert: class figures size equals: 1.
	self assert: class nameBox equals: class figures first.
	self assert: class nameBox figures size equals: 1.
	self assert: class attributesBox equals: nil.
	self assert: class methodsBox equals: nil