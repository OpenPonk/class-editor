examples
exampleCommonStructure
	| uml cs project |
	uml := OPUMLMetaElement umlMetamodel.
	cs := uml packagedElements detect: [ :each | each name = 'CommonStructure' ].
	(project := OPProject new)
		name: 'Project';
		addModel: cs.
	project open