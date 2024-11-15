Class {
	#name : 'OPUmlDiagramSetEndLabelsFigureCommand',
	#superclass : 'OPUmlDiagramEndLabelsFigureCommand',
	#category : 'OpenPonk-ClassEditor-Commands',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Commands'
}

{ #category : 'testing' }
OPUmlDiagramSetEndLabelsFigureCommand class >> isAbstract [

	^ self = OPUmlDiagramSetEndLabelsFigureCommand
]

{ #category : 'hooks' }
OPUmlDiagramSetEndLabelsFigureCommand class >> styleState [

	^ #''
]

{ #category : 'execution' }
OPUmlDiagramSetEndLabelsFigureCommand >> execute [

	self applicableDiagramElements do: [ :each |
		each showAssociationEndLabels: self styleState ]
]

{ #category : 'testing' }
OPUmlDiagramSetEndLabelsFigureCommand >> isCurrentlyActive [

	^ self applicableDiagramElements anySatisfy: [ :any |
		  any showAssociationEndLabels = self styleState ]
]

{ #category : 'testing' }
OPUmlDiagramSetEndLabelsFigureCommand >> isCurrentlySelected [

	^ super isCurrentlySelected or: [
		  self applicableDiagramElements allSatisfy: [ :each |
			  each owningElement exists not and: [
				  each showAssociationEndLabels = self styleState ] ] ]
]

{ #category : 'testing' }
OPUmlDiagramSetEndLabelsFigureCommand >> isCurrentlySelectedByStyle: aStyle [

	aStyle ifNil: [ ^ false ].
	^ aStyle
		  at: OPUmlAssociationEndLabel showAssociationEndLabelsKey
		  ifPresent: [ :styleValue | styleValue = self styleState ]
		  ifAbsent: [ false ]
]

{ #category : 'hooks' }
OPUmlDiagramSetEndLabelsFigureCommand >> styleState [

	^ self class styleState
]
