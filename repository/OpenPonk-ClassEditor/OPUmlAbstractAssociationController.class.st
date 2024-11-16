Class {
	#name : 'OPUmlAbstractAssociationController',
	#superclass : 'OPUmlRelationshipController',
	#category : 'OpenPonk-ClassEditor-Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Controllers'
}

{ #category : 'announcements' }
OPUmlAbstractAssociationController >> classAttributeChanged [

	super modelChanged
]

{ #category : 'accessing' }
OPUmlAbstractAssociationController >> elementsToShowInside [

	^ super elementsToShowInside , self model memberEnds
]

{ #category : 'announcements' }
OPUmlAbstractAssociationController >> modelChanged [

	super modelChanged.
	self model memberEnds
		select: [ :each | each owningClass isNotNil ]
		thenDo: [ :each |
			self diagramController
				controllerForModel: each
				ifFound: [ :controller | controller associationChanged ] ]
]

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
	self validateMemberEndCount.
	self model memberEnds do: [ :each | self validateProperty: each ].
	self model attributes do: [ :each | self validateProperty: each ]
]

{ #category : 'validation' }
OPUmlAbstractAssociationController >> validateMemberEndCount [

	self model memberEnds size = 2 ifTrue: [ ^ self ].

	OPModelInvalid signal: (String streamContents: [ :s |
			 s << self model asString << '" has '
			 << self model memberEnds size asString
			 << ' memberEnds instead of 2' ])
]
