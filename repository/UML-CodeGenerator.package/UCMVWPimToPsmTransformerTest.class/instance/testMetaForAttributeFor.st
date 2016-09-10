tests
testMetaForAttributeFor
	input := FAMIXAttribute named: 'item'.
	result := transformer metaForAttributeFor: input.
	self assert: (result collect: #name) equals: #(item_type)