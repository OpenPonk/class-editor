accessing
suffixMapping
	^ {(DCNamedElement -> [ :o | self classNameFor: o ]).
	(MooseEntity -> [ :o | self famixClassNameFor: o ])}