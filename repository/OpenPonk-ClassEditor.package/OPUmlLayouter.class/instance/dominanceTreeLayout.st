ui hooks
dominanceTreeLayout
	self
		applyLayout: [ :boxes :hierarchy :links | 
			RTDominanceTreeLayout new
				verticallyReverse;
				verticalGap: 100;
				horizontalGap: 100;
				doNotAttachPoint;
				on: boxes edges: hierarchy , links ]