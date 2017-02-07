tests
testMetaForAttributeFor2
	(input := FAMIXAttribute named: 'item')
		defaultValue: (OPFAMIXValueSpecification from: '15');
		unit: 'kg'.
	result := transformer metaForAttributeFor: input.
	self assert: (result collect: #name) equals: #(item_default item_type item_unit)