initialization
initialize
	super initialize.
	name := ''.
	(sourceEnd := OPFAMIXProperty new) association: self.
	(targetEnd := OPFAMIXProperty new) association: self