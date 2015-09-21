accessing
childrenMapping
	^ {(DCUmlClassDiagram -> #ownedElements).
	(MooseModel -> #allClasses).
	(MooseEntity -> #()).
	(FAMIXClass -> [ :o | o attributes , o methods ])}