visitor
visitLowerValue: aLowerValue
	writer
		tag: #lowerValue
		attributes: (Dictionary with: #xmi:type -> 'uml:LiteralInteger' with: #value -> aLowerValue asString)