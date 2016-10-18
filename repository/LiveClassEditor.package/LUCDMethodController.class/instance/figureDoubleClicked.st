as yet unclassified
figureDoubleClicked
	self model compiledMethod browse
	"(CodeCard class: self model parentType smalltalkClass selector: self model name asSymbol)
		fullBounds;
		toggleExpanded;
		openInWorld;
		center: self currentHand position"