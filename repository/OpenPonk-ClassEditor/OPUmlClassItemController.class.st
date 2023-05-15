Class {
	#name : #OPUmlClassItemController,
	#superclass : #OPUmlClassifierItemController,
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

{ #category : #removing }
OPUmlClassItemController >> removeModel [
	"could be any of those, so just nil all of them"

	model owningClass: nil.
	model datatype: nil.
	model interface: nil
]
