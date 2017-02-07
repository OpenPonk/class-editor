visitor
visitModel: aModel
	writer
		tag: #packagedElement
		attributes:
			(Dictionary
				with: #xmi:type -> 'uml:Package'
				with: #xmi:id -> aModel uuid asString
				with: #name -> aModel name)
		with: [ aModel allClasses do: [ :each | each accept: self ].
			aModel allBinaryAssociations do: [ :each | self visitBinaryAssociation: each ].
			types do: [ :each | each accept: self ] ]