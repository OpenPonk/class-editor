public
attributesFor: aClass
	^ self join: (aClass attributes collect: [ :each | self attributeToString: each ])