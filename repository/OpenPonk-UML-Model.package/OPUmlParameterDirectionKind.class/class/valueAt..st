enumeration - literals
valueAt: aString
	self class selectors
		detect: [ :each | each = aString ]
		ifFound: [ :each | ^ each value: self ]
		ifNone: [ self error: 'Unrecognized literal ' , aString ]