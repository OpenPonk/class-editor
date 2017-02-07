visitor
visitClass: aClass
	| attrs |
	attrs := Dictionary
		with: #xmi:type -> 'uml:Class'
		with: #xmi:id -> aClass uuid asString
		with: #name -> aClass name.
	aClass isAbstract
		ifTrue: [ attrs at: #isAbstract put: true asString ].
	writer
		tag: #packagedElement
		attributes: attrs
		with: [ aClass attributes do: [ :each | each accept: self ].
			aClass methods do: [ :each | each accept: self ].
			aClass superInheritances do: [ :each | each accept: self ] ]