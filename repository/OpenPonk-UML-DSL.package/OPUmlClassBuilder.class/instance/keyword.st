accessing
keyword
	^ ('<<' asParser trim , (symbol trim separatedBy: ',' asParser) withoutSeparators , '>>' asParser trimLeft) optional
		==>
			[ :nodes | 
			nodes
				ifNil: [ OrderedCollection new ]
				ifNotNil:
					[ (nodes second removeAllSuchThat: #isEmpty) collect: [ :each | OPFAMIXStereotype named: each ] as: OrderedCollection ] ]