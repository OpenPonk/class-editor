tests
testAttributeName
	| model name |
	model := FAMIXClass named: 'Something'.
	name := generator attributeNameFor: model.
	self assert: name equals: 'attribute'.
	model addAttribute: (FAMIXAttribute named: name).

	name := generator attributeNameFor: model.
	self assert: name equals: 'attribute1'.
	model addAttribute: (FAMIXAttribute named: name).

	name := generator attributeNameFor: model.
	self assert: name equals: 'attribute2'