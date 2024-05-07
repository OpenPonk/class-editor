"
I am a controller for an attribute of a classifier.
"
Class {
	#name : 'OPUmlAttributeController',
	#superclass : 'OPUmlClassItemController',
	#category : 'OpenPonk-ClassEditor-Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Controllers'
}

{ #category : 'figures' }
OPUmlAttributeController >> addDiagramElementToOwner [

	self diagramElementOwner addAttribute: diagramElement
]

{ #category : 'figures' }
OPUmlAttributeController >> createDiagramElement [

	(model name isNil or: [ model name trim isEmpty ]) ifTrue: [
		model name: self placeholderName ].
	super createDiagramElement
]

{ #category : 'construction' }
OPUmlAttributeController >> createModelIn: aClass [

	self model: (self modelClass new
			 name: self placeholderName;
			 yourself).
	aClass ownedAttributes add: model.
	^ model
]

{ #category : 'forms' }
OPUmlAttributeController >> descriptionDefaultValue [

	<magritteDescription>
	^ MAStringDescription new
		  accessor: (self descriptionAccessor: #defaultValue);
		  accessor: (MAPluggableAccessor
				   read: [ :me | 
					   me model defaultValue ifNil: [ '' ] ifNotNil: [ 
							   (me model defaultValue isKindOf: OPUMLOpaqueExpression)
								   ifTrue: [ me model defaultValue bodies first ]
								   ifFalse: [ '' ] ] ]
				   write: [ :me :newValue | 
					   me model defaultValue ifNil: [ 
							   me model defaultValue: OPUMLOpaqueExpression new ].
					   (me model defaultValue isKindOf: OPUMLOpaqueExpression) 
						   ifTrue: [ 
							   me model defaultValue bodies:
									   (newValue ifEmpty: [ {  } ] ifNotEmpty: [ { newValue } ]) ].
					   self refreshFigure ]);
		  label: 'Default Value';
		  priority: 42;
		  yourself
]

{ #category : 'forms' }
OPUmlAttributeController >> descriptionIsDerived [
	<magritteDescription>
	^ MABooleanDescription new
		accessor: (self descriptionAccessor: #isDerived);
		label: 'Is Derived';
		priority: 15;
		yourself
]

{ #category : 'forms' }
OPUmlAttributeController >> descriptionIsOrdered [
	<magritteDescription>
	^ MABooleanDescription new
		accessor: (self descriptionAccessor: #isOrdered);
		label: 'Is Ordered';
		priority: 35;
		yourself
]

{ #category : 'forms' }
OPUmlAttributeController >> descriptionIsReadOnly [
	<magritteDescription>
	^ MABooleanDescription new
		accessor: (self descriptionAccessor: #isReadOnly);
		label: 'Is Read Only';
		priority: 14;
		yourself
]

{ #category : 'forms' }
OPUmlAttributeController >> descriptionIsUnique [
	<magritteDescription>
	^ MABooleanDescription new
		accessor: (self descriptionAccessor: #isUnique);
		label: 'Is Unique';
		priority: 36;
		yourself
]

{ #category : 'forms' }
OPUmlAttributeController >> descriptionMultiplicity [

	<magritteDescription>
	^ MASingleOptionDescription new
		  beExtensible;
		  options: #( '0..1' '1..1' '0..*' '1..*' );
		  reference: MAStringDescription new;
		  accessor: (MAPluggableAccessor
				   read: [ :me | 
					   me model lowerBound asString , '..'
					   , me model upperBound asString ]
				   write: [ :me :newValue | 
					   self writeMultiplicityFrom: newValue to: me model.
					   self diagramElement modelChanged ]);
		  label: 'Multiplicity';
		  priority: 9;
		  beSorted;
		  yourself
]

{ #category : 'forms' }
OPUmlAttributeController >> descriptionType [

	<magritteDescription>
	^ MAStringDescription new
		  accessor: (MAPluggableAccessor
				   read: [ :me | me model type ifNil: [ '' ] ifNotNil: #name ]
				   write: [ :me :newValue | 
					   newValue
						   ifEmpty: [ me model type: nil ]
						   ifNotEmpty: [ me model type: (self typeNamed: newValue) ].
					   self diagramElement modelChanged ]);
		  label: 'Type';
		  priority: 5;
		  yourself
]

{ #category : 'figures' }
OPUmlAttributeController >> diagramElementClass [

	^ OPUmlAttributeLabel
]

{ #category : 'diagram elements' }
OPUmlAttributeController >> diagramElementOwner [

	^ (diagramController controllerForModel:
		   (model owningClass ifNil: [ 
			    (model owningAssociation memberEnds detect: [ :any | 
				     any ~= model ]) type ])) diagramElement
]

{ #category : 'accessing' }
OPUmlAttributeController >> modelClass [
	^ OPUMLProperty
]

{ #category : 'hooks' }
OPUmlAttributeController >> placeholderName [

	^ 'attribute'
]

{ #category : 'removing' }
OPUmlAttributeController >> removeDiagramElement [

	self diagramElement ifNil: [ ^ self ].
	self diagramElementOwner ifNotNil: [ :owner |
		owner removeAttribute: self diagramElement ].
	diagramElement := nil
]

{ #category : 'accessing' }
OPUmlAttributeController >> typeNamed: aName [
	OPUMLXMISpecsStorage primitivesMap at: aName ifPresent: [ :prim | ^ prim ].
	(diagramController model packagedElements select: [ :each | each oclIsKindOf: #Type ])
		detect: [ :each | each name = aName ]
		ifFound: [ :type | ^ type ].
	^ OPUMLClass new name: aName
]

{ #category : 'forms' }
OPUmlAttributeController >> writeMultiplicityFrom: aString to: aProperty [
	| values |
	(aString includesSubstring: '..')
		ifTrue: [ | split |
			split := aString splitOn: '..'.
			values := {split first asNumber.
			split second = '*'
				ifTrue: [ '*' ]
				ifFalse: [ split second asNumber ]} ]
		ifFalse: [ aString = '*'
				ifTrue: [ values := #(0 '*') ]
				ifFalse: [ values := {aString asNumber.
					aString asNumber} ] ].
	aProperty lowerValue ifNil: [ aProperty lowerValue: OPUMLLiteralInteger new ].
	aProperty upperValue ifNil: [ aProperty upperValue: OPUMLLiteralUnlimitedNatural new ].
	aProperty lowerValue value: values first.
	aProperty upperValue value: values second
]
