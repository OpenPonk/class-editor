accessing
displayMapping
	^ {(DCNamedElement -> #name).
	(MooseEntity -> #name).
	(FAMIXAttribute
		->
			[ :o | o name , (o declaredType ifNil: [ '' ] ifNotNil: [ ' : ' , o declaredType name ]) ]).
	(FAMIXMethod
		->
			[ :o | o name , (o declaredType ifNil: [ '' ] ifNotNil: [ ' : ' , o declaredType name ]) ])}