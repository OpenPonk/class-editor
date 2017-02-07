tests
testType
	self parse: ' --- ' rule: #type.
	self parse: ' <-> ' rule: #type.
	self parse: ' <-- ' rule: #type.
	self parse: ' <>-<> ' rule: #type.
	self parse: ' <*>-<*> ' rule: #type