Class {
	#name : 'OPUmlAbstractAssociationController',
	#superclass : 'OPUmlRelationshipController',
	#category : 'OpenPonk-ClassEditor-Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Controllers'
}

{ #category : 'accessing' }
OPUmlAbstractAssociationController >> modelSource [

	^ self model memberEnds ifNotEmpty: [ :memberEnds |
		  memberEnds first type ]
]

{ #category : 'accessing' }
OPUmlAbstractAssociationController >> modelTarget [

	^ self model memberEnds size > 1
		  ifTrue: [ self model memberEnds second type ]
		  ifFalse: [ nil ]
]

{ #category : 'removing' }
OPUmlAbstractAssociationController >> removeModel [

	[ self model memberEnds isNotEmpty ] whileTrue: [
		| end |
		end := self model memberEnds anyOne.
		end association: nil.
		end owningClass: nil.
		end owningAssociation: nil ].
	super removeModel
]

{ #category : 'validation' }
OPUmlAbstractAssociationController >> validate [

	super validate.
	self model memberEnds do: [ :each | self validateProperty: each ].
	self model attributes do: [ :each | self validateProperty: each ]
]
