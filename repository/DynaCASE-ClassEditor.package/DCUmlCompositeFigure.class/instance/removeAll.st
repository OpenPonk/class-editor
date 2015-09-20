adding/removing
removeAll
	figures
		do: [ :each | 
			each parent: nil.
			each remove ].
	figures removeAll.
	self changed