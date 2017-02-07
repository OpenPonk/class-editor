accessing
suffixMapping
	^ {(OPNamedElement -> [ :o | self classNameFor: o ]).
	(MooseEntity -> [ :o | self famixClassNameFor: o ])}