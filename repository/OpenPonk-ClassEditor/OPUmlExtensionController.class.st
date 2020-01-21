"
I am a controller for UML Extensions
"
Class {
	#name : #OPUmlExtensionController,
	#superclass : #OPUmlRelationshipController,
	#category : 'OpenPonk-ClassEditor-Controllers'
}

{ #category : #figures }
OPUmlExtensionController >> createDiagramElement [
	^ OPUmlExtensionShape new
		modelElement: self model;
		yourself
]

{ #category : #construction }
OPUmlExtensionController >> createModelIn: aTargetController andShowInDiagram: aDiagramController [
	| sourceOwnedProp extensionOwnedProp |
	self model: self createModel.
	(sourceOwnedProp := OPUMLProperty new)
		owningClass: sourceController model;
		name: 'base_' , aTargetController model name;
		type: aTargetController model.
	(extensionOwnedProp := OPUMLExtensionEnd new)
		name: 'extension_' , sourceController model name;
		type: sourceController model.
	model ownedEnd: extensionOwnedProp.
	model memberEnds
		add: sourceOwnedProp;
		add: extensionOwnedProp.
	aDiagramController model packagedElements add: model.
	aDiagramController addController: self.
	self showInDiagram: aDiagramController.
	{sourceOwnedProp}
		do: [ :each | 
			| subCtrl |
			subCtrl := aDiagramController newControllerFor: each.
			aDiagramController addController: subCtrl.
			subCtrl showInDiagram: aDiagramController ]
]

{ #category : #accessing }
OPUmlExtensionController >> modelClass [
	^ OPUMLExtension
]

{ #category : #figures }
OPUmlExtensionController >> refreshFigure [
	self diagramElement changed
]

{ #category : #removing }
OPUmlExtensionController >> removeModel [
	| ctrls owner |
	owner := self diagramController model.
	"extra work to trigger update of the end classes... maybe this should be automatic for edges"
	ctrls := self model memberEnds asArray
		collect: [ :each | diagramController controllerForModel: each type ].
	self remove.
	owner packagedElements remove: self model.
	[ self model memberEnds isNotEmpty ]
		whileTrue: [ | end |
			end := self model memberEnds first.
			end association: nil.
			end owningClass: nil.
			end owningAssociation: nil ].
	ctrls do: #refreshFigure
]

{ #category : #figures }
OPUmlExtensionController >> renderFigureIn: aView [
	diagramElement := self createDiagramElement.
	diagramElement
		ends:
			{diagramController diagramElementForModel: self model ownedEnd type.
			diagramController
				diagramElementForModel: (self model memberEnds copyWithout: self model ownedEnd) first type}.
	diagramElement renderIn: aView.
	diagramController figureAdded: self figure.
	self refreshFigure
]
