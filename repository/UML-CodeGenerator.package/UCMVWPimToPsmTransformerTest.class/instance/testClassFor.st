tests
testClassFor
	input := FAMIXClass named: 'Item'.
	input addAttribute: (FAMIXAttribute named: 'item').
	input addMethod: (FAMIXMethod named: 'asItem').
	result := transformer classFor: input.
	self deny: result = input.
	self assert: result name equals: 'Item'.
	self assert: result attributes first name equals: 'item'.
	self deny: result attributes first = input attributes first.
	self assert: (result methods collect: #name) asArray equals: #(item item: item_type asItem).
	self deny: result methods last = input methods last