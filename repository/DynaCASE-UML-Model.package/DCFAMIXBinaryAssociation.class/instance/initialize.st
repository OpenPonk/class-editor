accessing
initialize
	super initialize.
	name := ''.
	(sourceEnd := DCFAMIXProperty new) belongsTo: self.
	(targetEnd := DCFAMIXProperty new) belongsTo: self