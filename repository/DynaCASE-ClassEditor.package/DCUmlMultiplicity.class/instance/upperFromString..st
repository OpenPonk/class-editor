accessing
upperFromString: aString
	self
		upper:
			(aString = '*'
				ifTrue: [ Float infinity ]
				ifFalse: [ aString asInteger ])