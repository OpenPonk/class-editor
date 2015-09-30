accessing
childrenMapping
	^ {(MooseModel -> #allModelClasses).
	(MooseEntity -> #()).
	(FAMIXClass -> [ :o | o attributes , o methods ])}