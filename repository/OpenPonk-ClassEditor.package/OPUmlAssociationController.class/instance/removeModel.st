removing
removeModel
	self remove.
	[ self model memberEnds isNotEmpty ]
		whileTrue: [ self model memberEnds first association: nil ]