ui hooks
circleLayout
	self
		applyLayout: [ :boxes :hierarchy :links | 
			RTWeightedCircleLayout new
				scaleBy: 20;
				on: boxes ]