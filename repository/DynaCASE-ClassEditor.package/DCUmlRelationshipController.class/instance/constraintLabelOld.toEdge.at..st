as yet unclassified
constraintLabelOld: aLabel toEdge: anEdge at: aPosition
	aPosition = #start
		ifTrue:
			[ 
			DCRTRailConstraint new
				initialPosition: 10;
				distance: 50;
				element: aLabel connection: anEdge ].
	aPosition = #end
		ifTrue:
			[ 
			DCRTEdgeEndConstraint
				stick: aLabel
				nearStartOfEdge: anEdge
				distance: 10
				offset: 20.
			DCRTElementsConstraint
				whenDragging: aLabel
				drawLineToPoint:
					[ (anEdge shape startingPointOf: anEdge) * 0.9 + ((anEdge shape endingPointOf: anEdge) * 0.1) ] ].
	aPosition = #middle
		ifTrue:
			[ 
			DCRTEdgeAlongConstraint
				stick: aLabel
				alongEdge: anEdge
				balance: 10
				offset: 20.
			DCRTElementsConstraint
				whenDragging: aLabel
				drawLineToPoint:
					[ ((anEdge shape startingPointOf: anEdge) + (anEdge shape endingPointOf: anEdge)) / 2 ] ]