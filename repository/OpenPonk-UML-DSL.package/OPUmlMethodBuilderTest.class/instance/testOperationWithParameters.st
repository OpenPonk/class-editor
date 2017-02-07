tests
testOperationWithParameters
	self parse: 'op(first: String, second: Number[2..5])' rule: #operation.
	self assertModel: result equals: self operationWithParameters