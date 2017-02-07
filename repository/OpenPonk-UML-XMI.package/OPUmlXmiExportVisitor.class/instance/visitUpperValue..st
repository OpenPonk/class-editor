visitor
visitUpperValue: anUpperValue
	writer
		tag: #upperValue
		attributes:
			(Dictionary
				with: #xmi:type -> 'uml:LiteralUnlimitedNatural'
				with: #value -> anUpperValue printValue)