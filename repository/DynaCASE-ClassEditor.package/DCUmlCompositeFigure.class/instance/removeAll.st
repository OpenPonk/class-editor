adding
removeAll
	figures
		do: [ :each | 
			each parent: nil.
			each remove ].
	figures removeAll.
	self update.
	self updateParent