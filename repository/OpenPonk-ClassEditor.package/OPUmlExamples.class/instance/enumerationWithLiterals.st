accessing
enumerationWithLiterals
	<gtExample>
	| enumeration |
	enumeration := self emptyEnumeration.
	#(public private protected package)
		do: [ :each | 
			| literal |
			literal := OPUMLEnumerationLiteral new name: each.
			enumeration ownedLiterals add: literal ].
	^ enumeration