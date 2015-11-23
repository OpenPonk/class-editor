tests
testProperty
	self parse: 'name' rule: #property.
	self parse: '+name: Type' rule: #property.
	self parse: 'name : Type' rule: #property.
	self parse: '+name: Type[1..2]' rule: #property.
	self parse: 'name : Type = defaultValue' rule: #property.
	self parse: 'name : Type[1..4] = defaultValue' rule: #property