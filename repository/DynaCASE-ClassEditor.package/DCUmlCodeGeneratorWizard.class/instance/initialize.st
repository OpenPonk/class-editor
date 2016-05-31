initialize-release
initialize
	super initialize.
	self addConfigPane.
	self
		atEndDo: [ :dictionary | 
			LastValues := dictionary.
			self runGeneratorWith: (self createContextFrom: dictionary) ]