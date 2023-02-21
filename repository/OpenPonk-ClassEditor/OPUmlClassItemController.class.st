Class {
	#name : #OPUmlClassItemController,
	#superclass : #OPUmlElementController,
	#category : #'OpenPonk-ClassEditor-Controllers'
}

{ #category : #forms }
OPUmlClassItemController >> descriptionIsStatic [
	<magritteDescription>
	^ MABooleanDescription new
		accessor: (self descriptionAccessor: #isStatic);
		label: 'Is Static';
		priority: 10;
		yourself
]

{ #category : #forms }
OPUmlClassItemController >> descriptionName [

	<magritteDescription>
	| description |
	description := super descriptionName.
	description accessor writeBlock: [ :me :newValue | 
		me model name: newValue.
		self diagramElementOwner updateRenderFromModel ].
	^ description
]

{ #category : #announcements }
OPUmlClassItemController >> internalSubscribeTo: aModel [

	aModel announcer
		when: OPElementRenamed
		do: [ self diagramElementOwner updateRenderFromModel ]
]

{ #category : #testing }
OPUmlClassItemController >> isHideable [
	^ true
]

{ #category : #removing }
OPUmlClassItemController >> removeModel [
	"could be any of those, so just nil all of them"

	model owningClass: nil.
	model datatype: nil.
	model interface: nil
]
