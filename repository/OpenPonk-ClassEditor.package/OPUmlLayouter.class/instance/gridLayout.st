ui hooks
gridLayout
	self
		applyLayout: [ :boxes :hierarchy :links | 
			RTGridLayout new
				gapSize: 140;
				on: boxes ]