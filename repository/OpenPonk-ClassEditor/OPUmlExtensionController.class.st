"
I am a controller for UML Extensions
"
Class {
	#name : #OPUmlExtensionController,
	#superclass : #OPUmlRelationshipController,
	#category : #'OpenPonk-ClassEditor-Controllers'
}

{ #category : #figures }
OPUmlExtensionController >> createDiagramElement [
	^ OPUmlExtensionShape new
		modelElement: self model;
		yourself
]

{ #category : #construction }
OPUmlExtensionController >> createModelIn: aParentModel [
	| sourceOwnedProp extensionOwnedProp |
	self model: self modelClass new.
	(sourceOwnedProp := OPUMLProperty new)
		owningClass: source model;
		name: 'base_' , aParentModel name;
		type: aParentModel.
	(extensionOwnedProp := OPUMLExtensionEnd new)
		name: 'extension_' , source model name;
		type: source model.
	model ownedEnd: extensionOwnedProp.
	model memberEnds
		add: sourceOwnedProp;
		add: extensionOwnedProp.
	source diagramController model packagedElements add: model.
	^ model
]

{ #category : #accessing }
OPUmlExtensionController >> dependentElements [
	^ {model memberEnds first}
]

{ #category : #accessing }
OPUmlExtensionController >> modelClass [
	^ OPUMLExtension
]

{ #category : #figures }
OPUmlExtensionController >> refreshFigure [
	self diagramElement changed.
	^ self figure
]

{ #category : #removing }
OPUmlExtensionController >> removeController [
	".		
	ctrls := self model memberEnds asArray
		collect: [ :each | diagramController controllerForModel: each type ].
	ctrls do: #refreshFigure"

	super removeController
]

{ #category : #removing }
OPUmlExtensionController >> removeModel [
	"extra work to trigger update of the end classes... maybe this should be automatic for edges"

	self diagramController model packagedElements remove: self model.
	[ self model memberEnds isNotEmpty ]
		whileTrue: [ | end |
			end := self model memberEnds first.
			end association: nil.
			end owningClass: nil.
			end owningAssociation: nil ]
]

{ #category : #figures }
OPUmlExtensionController >> renderFigureIn: aView [
	self diagramController addingFigureFor: self.
	diagramElement := self createDiagramElement.
	diagramElement
		ends:
			{diagramController diagramElementForModel: self model ownedEnd type.
			diagramController
				diagramElementForModel: (self model memberEnds copyWithout: self model ownedEnd) first type}.
	diagramElement renderIn: aView.
	diagramController addedFigureFor: self.
	^ self refreshFigure
]
