initialize-release
initialize
	super initialize.
	self addConfigPane.
	self atEndDo: [ :dictionary | self runGeneratorWith: dictionary ]