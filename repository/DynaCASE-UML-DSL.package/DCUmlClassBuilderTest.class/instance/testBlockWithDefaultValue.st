tests
testBlockWithDefaultValue
	self
		parse:
			'{
	attr : String = ''hello''
}'
		rule: #block.
	self assert: result size equals: 1