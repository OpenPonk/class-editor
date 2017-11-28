initialization
initialize
	super initialize.
	self addGeneratePane.
	self atEndDo: [ :values | self generateWith: values ]