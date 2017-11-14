ui hooks
buildMenuOn: aBuilder parent: aParent
	(aBuilder item: 'Dominance Tree')
		parent: aParent;
		action: [ self dominanceTreeLayout ].
	(aBuilder item: 'Tree')
		parent: aParent;
		action: [ self treeLayout ].
	(aBuilder item: 'Sugiyama')
		parent: aParent;
		action: [ self sugiyamaLayout ].
	(aBuilder item: 'Grid')
		parent: aParent;
		action: [ self gridLayout ].
	(aBuilder item: 'Circle')
		parent: aParent;
		action: [ self circleLayout ]