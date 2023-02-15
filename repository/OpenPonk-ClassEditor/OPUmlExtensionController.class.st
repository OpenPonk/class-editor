"
I am a controller for UML Extensions
"
Class {
	#name : #OPUmlExtensionController,
	#superclass : #OPUmlRelationshipController,
	#category : #'OpenPonk-ClassEditor-Controllers'
}

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

{ #category : #figures }
OPUmlExtensionController >> diagramElementClass [

	^ OPUmlExtensionShape
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
