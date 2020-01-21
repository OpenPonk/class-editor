Extension { #name : #String }

{ #category : #'*OpenPonk-UML-DSL' }
String >> asClassDiagram [
	^ self asClassDiagram: ''
]

{ #category : #'*OpenPonk-UML-DSL' }
String >> asClassDiagram: aDiagramName [
	^ (OPUmlDslParser parse: self)
		name: aDiagramName;
		yourself
]
