visitor
visitBinaryAssociation: anAssociation
	| attrs |
	attrs := Dictionary
		with: #xmi:type -> 'uml:Association'
		with: #xmi:id -> anAssociation uuid asString
		with: #name -> anAssociation name.
	writer
		tag: #packagedElement
		attributes: attrs
		with: [ self visitOwnedEnd: anAssociation sourceEnd.
			self visitOwnedEnd: anAssociation targetEnd ]