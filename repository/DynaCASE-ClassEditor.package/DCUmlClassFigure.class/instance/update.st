updating
update
	| maxWidth |
	super update.
	maxWidth := figures max: [ :each | each extent x ].

	self
		figuresDo: [ :each | 
			| delta |
			delta := (each width - maxWidth) / 2.
			each width: maxWidth.
			each figuresDo: [ :f | f translateBy: delta @ 0 ] ].

	self applyLayout.
	self doNest