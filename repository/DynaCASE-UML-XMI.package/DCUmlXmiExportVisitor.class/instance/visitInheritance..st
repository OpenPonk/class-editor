visitor
visitInheritance: anInheritance
	writer
		tag: #generalization
		attributes:
			(Dictionary
				with: #xmi:type -> 'uml:Generalization'
				with: #xmi:id -> anInheritance uuid asString
				with: #general -> anInheritance superclass uuid asString)