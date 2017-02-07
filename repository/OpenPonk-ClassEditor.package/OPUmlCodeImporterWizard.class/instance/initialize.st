initialize-release
initialize
	super initialize.
	self addPackagePane.
	self atEndDo: [ :dictionary | self importWith: dictionary ]