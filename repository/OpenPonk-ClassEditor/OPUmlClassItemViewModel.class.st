"
I am the base ViewModel for items contained within a UML Class, such as properties (attributes) or operations.
"
Class {
	#name : 'OPUmlClassItemViewModel',
	#superclass : 'OPUmlClassifierItemViewModel',
	#category : 'OpenPonk-ClassEditor-ViewModels',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'ViewModels'
}

{ #category : 'private' }
OPUmlClassItemViewModel >> basicRemoveModel [
	"could be any of those, so just nil all of them"

	self model owningClass: nil.
	self model interface: nil.
	self model datatype: nil
]

{ #category : 'accessing' }
OPUmlClassItemViewModel >> dependingOnElements [
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
OPUmlClassItemViewModel >> descriptionIsStatic [
	<magritteDescription>
	^ MABooleanDescription new
		accessor: (self descriptionAccessor: #isStatic);
		label: 'Is Static';
		priority: 10;
		yourself
]
