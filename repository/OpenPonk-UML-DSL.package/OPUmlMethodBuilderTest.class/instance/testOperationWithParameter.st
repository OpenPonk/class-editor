tests
testOperationWithParameter
	self parse: 'op(arg)' rule: #operation.
	self assertModel: result equals: self operationWithParameter