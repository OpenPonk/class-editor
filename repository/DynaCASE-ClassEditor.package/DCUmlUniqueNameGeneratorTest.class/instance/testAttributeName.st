tests
testAttributeName
	| model name |
	model := FAMIXClass named: 'Something'.
	name := generator attributeNameFor: model.
	self assert: name equals: 'Attribute'.
	model addAttribute: (FAMIXAttribute named: name).

	name := generator attributeNameFor: model.
	self assert: name equals: 'Attribute1'.
	model addAttribute: (FAMIXAttribute named: name).

	name := generator attributeNameFor: model.
	self assert: name equals: 'Attribute2'