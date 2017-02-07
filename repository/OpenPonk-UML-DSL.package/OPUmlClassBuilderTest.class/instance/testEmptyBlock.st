tests
testEmptyBlock
	self parse: '{}' rule: #block.
	self parse: '{ }' rule: #block.
	self
		parse:
			'{
}'
		rule: #block