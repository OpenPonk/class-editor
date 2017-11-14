ui hooks
applyBasicLayout
	| classes generalizations |
	classes := self model packagedElements select: [ :each | each oclIsKindOf: OPUMLClass ].
	generalizations := classes flatCollect: [ :each | each generalizations, each extensions ].
	RTDominanceTreeLayout new
		verticallyReverse;
		verticalGap: 100;
		horizontalGap: 70;
		doNotAttachPoint;
		on: (classes collect: [ :each | (self controllerForModel: each) figure ])
			edges: (generalizations collect: [ :each | (self controllerForModel: each) figure ]).
	self view canvas camera focusOnCenter