accessing
childrenMapping
	^ {(MooseModel -> #allModelClasses).
	(MooseEntity -> #()).
	(FAMIXClass -> [ :o | o stereotypes , o attributes , o methods ])}