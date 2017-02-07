as yet unclassified
constraintLabel: aLabel toEdge: anEdge at: aPosition side: aSide
	| config anchor |
	config := Dictionary
		with: #start -> (Array with: -10 with: aSide * 10)
		with: #end -> (Array with: 10 with: aSide * 10)
		with: #middle -> (Array with: 0.5 with: 10).
	anchor := OPRTAnchorConstraint new.
	anchor
		element: aLabel;
		edge: anEdge;
		balance: (config at: aPosition) first;
		minDistance: (config at: aPosition) second;
		build