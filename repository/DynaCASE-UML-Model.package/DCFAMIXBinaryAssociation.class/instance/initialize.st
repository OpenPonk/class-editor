initialization
initialize
	super initialize.
	name := ''.
	(sourceEnd := DCFAMIXProperty new) association: self.
	(targetEnd := DCFAMIXProperty new) association: self