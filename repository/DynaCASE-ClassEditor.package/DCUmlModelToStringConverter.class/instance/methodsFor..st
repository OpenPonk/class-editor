public
methodsFor: aClass
	^ self join: (aClass methods collect: [ :each | self methodToString: each ])