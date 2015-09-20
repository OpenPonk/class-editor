updating
layout
	RTVerticalLineLayout new
		gapSize: 0;
		on: figures.

	RTNestingBehavior new
		centerOn: element elements: figures;
		resize: element for: figures padding: 0