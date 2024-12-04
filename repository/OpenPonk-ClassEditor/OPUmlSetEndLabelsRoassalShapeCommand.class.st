Class {
	#name : 'OPUmlSetEndLabelsRoassalShapeCommand',
	#superclass : 'OPUmlEndLabelsRoassalShapeCommand',
	#category : 'OpenPonk-ClassEditor-Commands',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Commands'
}

{ #category : 'testing' }
OPUmlSetEndLabelsRoassalShapeCommand class >> isAbstract [

	^ self = OPUmlSetEndLabelsRoassalShapeCommand
]

{ #category : 'hooks' }
OPUmlSetEndLabelsRoassalShapeCommand class >> styleState [

	^ #''
]

{ #category : 'execution' }
OPUmlSetEndLabelsRoassalShapeCommand >> execute [

	self applicableDiagramElements do: [ :each |
		each showAssociationEndLabels: self styleState ]
]

{ #category : 'testing' }
OPUmlSetEndLabelsRoassalShapeCommand >> isCurrentlyActive [

	^ self applicableDiagramElements anySatisfy: [ :any |
		  any showAssociationEndLabels = self styleState ]
]

{ #category : 'testing' }
OPUmlSetEndLabelsRoassalShapeCommand >> isCurrentlySelected [

	^ super isCurrentlySelected or: [
		  self applicableDiagramElements allSatisfy: [ :each |
			  each owningElement exists not and: [
				  each showAssociationEndLabels = self styleState ] ] ]
]

{ #category : 'testing' }
OPUmlSetEndLabelsRoassalShapeCommand >> isCurrentlySelectedByStyle: aStyle [

	aStyle ifNil: [ ^ false ].
	^ aStyle
		  at: OPUmlAssociationEndLabel showAssociationEndLabelsKey
		  ifPresent: [ :styleValue | styleValue = self styleState ]
		  ifAbsent: [ false ]
]

{ #category : 'hooks' }
OPUmlSetEndLabelsRoassalShapeCommand >> styleState [

	^ self class styleState
]
