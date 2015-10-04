*DynaCASE-ClassEditor-Updating
layout
	RTVerticalLineLayout new
		gapSize: 0;
		on: self figures.

	RTNestingBehavior new
		centerOn: self rtElement elements: self figures;
		resize: self rtElement for: self figures padding: 5.

	self labels
		do:
			[ :each | each translateTo: self rtElement position x @ each rtElement position y - (0 @ 2.5) ]