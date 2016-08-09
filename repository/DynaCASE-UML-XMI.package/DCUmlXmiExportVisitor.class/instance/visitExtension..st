visitor
visitExtension: aModel
	aModel allClasses
		do: [ :cls | 
			| attrs |
			attrs := Dictionary
				with: #xmi:type -> 'uml:Class'
				with: #xmi:id -> cls uuid asString
				with: #name -> cls name.
			writer
				tag: #packagedElement
				attributes: attrs
				with: [ cls stereotypes do: [ :each | each accept: self ] ] ]