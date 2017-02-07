tests
testAttributeWithDefaultValue
	self
		export: (self parseAttribute: 'workDays : String[5] = #(Monday Tuesday Wednesday Thursday Friday)')
		equals: 'workDays : String[5] = #(Monday Tuesday Wednesday Thursday Friday)'