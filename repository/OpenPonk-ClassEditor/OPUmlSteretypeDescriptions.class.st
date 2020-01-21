"
I take a model element and provide a list of magritte descriptions for all the properties added by stereotypes applied to the model element.
"
Class {
	#name : #OPUmlSteretypeDescriptions,
	#superclass : #Object,
	#instVars : [
		'controller'
	],
	#category : 'OpenPonk-ClassEditor-Profiles'
}

{ #category : #'as yet unclassified' }
OPUmlSteretypeDescriptions >> accessorFor: anAttribute of: aStereotype [
	^ MAPluggableAccessor
		read: [ :me | aStereotype perform: anAttribute name asSymbol ]
		write: [ :me :newValue | 
			aStereotype perform: (anAttribute name , ':') asSymbol with: newValue.
			controller refreshFigure ]
]

{ #category : #adding }
OPUmlSteretypeDescriptions >> addTo: aCollection attribute: anAttribute of: aStereotype [
	anAttribute type name = #Boolean
		ifTrue: [ aCollection
				add:
					(MABooleanDescription new
						accessor: (self accessorFor: anAttribute of: aStereotype);
						label: 'Is ' , anAttribute name capitalized;
						yourself) ].
	anAttribute type name = #String
		ifTrue: [ aCollection
				add:
					(MAStringDescription new
						accessor: (self accessorFor: anAttribute of: aStereotype);
						label: anAttribute name capitalized;
						yourself) ]
]

{ #category : #accessing }
OPUmlSteretypeDescriptions >> controller [
	^ controller
]

{ #category : #accessing }
OPUmlSteretypeDescriptions >> controller: anObject [
	controller := anObject
]

{ #category : #'as yet unclassified' }
OPUmlSteretypeDescriptions >> descriptions [
	| descriptions |
	self model ifNil: [ ^ #() ].
	descriptions := OrderedCollection new.
	self model appliedStereotypes
		do: [ :stereo | 
			| meta |
			meta := stereo umlMetaClass.
			meta allAttributes
				do: [ :attr | self addTo: descriptions attribute: attr of: stereo ] ].
	^ descriptions
]

{ #category : #accessing }
OPUmlSteretypeDescriptions >> model [
	^ controller model
]
