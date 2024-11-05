Class {
	#name : 'OPUmlClassItemController',
	#superclass : 'OPUmlClassifierItemController',
	#category : 'OpenPonk-ClassEditor-Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Controllers'
}

{ #category : 'construction' }
OPUmlClassItemController >> dependingOnElements [

	| asSetOrEmpty |
	asSetOrEmpty := [ :nullableElement |
	                nullableElement
		                ifNil: [ Set empty ]
		                ifNotNil: [ :element | Set with: element ] ].
	^ super dependingOnElements
	  , (asSetOrEmpty value: self model owningClass)
	  , (asSetOrEmpty value: self model interface)
	  , (asSetOrEmpty value: self model datatype)
]

{ #category : 'forms' }
OPUmlClassItemController >> descriptionIsStatic [
	<magritteDescription>
	^ MABooleanDescription new
		accessor: (self descriptionAccessor: #isStatic);
		label: 'Is Static';
		priority: 10;
		yourself
]

{ #category : 'removing' }
OPUmlClassItemController >> removeModel [
	"could be any of those, so just nil all of them"

	self model owningClass: nil.
	self model interface: nil.
	self model datatype: nil.
	super removeModel
]
