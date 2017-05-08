ui hooks
addAllElements
	self showAllElements.
	[ self flag: 'temporary hack so I see what I am doing on the canvas'.
	RTDominanceTreeLayout new
		doNotAttachPoint;
		verticallyReverse;
		verticalGap: 50;
		horizontalGap: 50;
		on:
			(self model packagedElements
				select: [ :each | each isKindOf: OPUMLClass ]
				thenCollect: [ :each | (self controllerForModel: each) figure ]).
	self view canvas camera focusOnCenter ] value