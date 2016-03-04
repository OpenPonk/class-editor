accessing
keyword
	^ ('<<' asParser trim , (symbol trim separatedBy: ',' asParser) withoutSeparators , '>>' asParser trimLeft) optional
		==>
			[ :nodes | 
			nodes
				ifNil: [ OrderedCollection new ]
				ifNotNil:
					[ (nodes second removeAllSuchThat: #isEmpty) collect: [ :each | DCFAMIXStereotype named: each ] as: OrderedCollection ] ]