tests
testSortHierarchy
	| parent child |
	model := '
Parent {  }
Third {  }
Child {  }
Child >> Parent;
' asClassDiagram.
	parent := model allModelClasses detect: [ :each | each name = 'Parent' ].
	child := model allModelClasses detect: [ :each | each name = 'Child' ].
	self
		assert: ((generator sortedHierarchyFor: model allModelClasses) asArray collect: #name)
		equals: #(Parent Third Child)