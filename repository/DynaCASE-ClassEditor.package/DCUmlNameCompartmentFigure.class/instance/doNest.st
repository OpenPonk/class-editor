as yet unclassified
doNest
	RTNestingBehavior new
		centerOn: element elements: figures;
		resize: element for: figures.
	self parent ifNotNil: [ self element width: self parent width ]