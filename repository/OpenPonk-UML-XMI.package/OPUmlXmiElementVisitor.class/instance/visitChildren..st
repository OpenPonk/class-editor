visitor
visitChildren: anElement
	anElement nodes do: [ :each | self visit: each ]