accessing
useNiceIds: aPackage
	aPackage uuid: '_0'.
	aPackage packagedElements
		select: [ :each | each oclIsKindOf: #Class ]
		thenDo: [ :cls | 
			cls uuid: cls name.
			cls ownedAttributes do: [ :attr | attr uuid: cls uuid , '-' , attr name ] ].
	aPackage packagedElements
		select: [ :each | each oclIsKindOf: #Association ]
		thenDo:
			[ :each | each uuid: ((each memberEnds collect: [ :memb | memb type name ]) joinUsing: $_) ]