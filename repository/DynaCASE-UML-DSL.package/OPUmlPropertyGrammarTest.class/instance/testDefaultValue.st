tests
testDefaultValue
	self parse: '= 10' rule: #defaultValue.
	self parse: '= #(1 2 3)' rule: #defaultValue.
	self parse: '= ''str''' rule: #defaultValue