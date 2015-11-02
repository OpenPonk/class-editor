as yet unclassified
constraintLabel: aLabel toEdge: anEdge at: aPosition side: aSide
	aPosition = #start
		ifTrue:
			[ | anchor |
			anchor := DCRTAnchorConstraint new.
			anchor
				element: aLabel;
				edge: anEdge;
				balance: 10;
				minDistance: aSide * 10;
				build ].
	aPosition = #end
		ifTrue:
			[ | anchor |
			anchor := DCRTAnchorConstraint new.
			anchor
				element: aLabel;
				edge: anEdge;
				balance: -10;
				minDistance: aSide * 10;
				build ].
	aPosition = #middle
		ifTrue:
			[ | anchor |
			anchor := DCRTAnchorConstraint new.
			anchor
				element: aLabel;
				edge: anEdge;
				balance: 0.5;
				minDistance: 10;
				build ]