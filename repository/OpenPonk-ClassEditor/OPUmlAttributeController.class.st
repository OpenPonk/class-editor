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

	self ownerDiagramElement addAttribute: diagramElement
]

{ #category : 'figures' }
OPUmlAttributeController >> createDiagramElement [

	(model name isNil or: [ model name trim isEmpty ]) ifTrue: [
		model name: self placeholderName ].
	super createDiagramElement
]

{ #category : 'construction' }
OPUmlAttributeController >> createModelIn: aClass [

	^ (super createModelIn: aClass)
		  name: self placeholderName;
		  yourself
]

{ #category : 'construction' }
OPUmlAttributeController >> dependingOnElements [

	| asSetOrEmpty |
	asSetOrEmpty := [ :nullableElement |
	                nullableElement
		                ifNil: [ Set empty ]
		                ifNotNil: [ :element | Set with: element ] ].

	^ super dependingOnElements
	  , (asSetOrEmpty value: model owningAssociation)
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
					   self diagramElement modelChanged ]);
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

{ #category : 'accessing' }
OPUmlAttributeController >> modelClass [
	^ OPUMLProperty
]

{ #category : 'diagram elements' }
OPUmlAttributeController >> owner [

	^ diagramController controllerForModel: (model owningClass ifNil: [
			   (model owningAssociation memberEnds detect: [ :any |
				    any ~= model ]) type ])
]

{ #category : 'hooks' }
OPUmlAttributeController >> placeholderName [

	(self model isNil or: [
		 self model type isNil or: [
			 self model type name isNil or: [ self model type name isEmpty ] ] ])
		ifTrue: [ ^ 'attribute' ].
	^ String streamContents: [ :s |
		  | words |
		  words := (self model type name select: [ :each |
			            each isAlphaNumeric or: [ each isSeparator ] ])
			           splitOn: [ :each | each isSeparator ].
		  s << words first first asLowercase asString.
		  s << words first allButFirst asString.
		  words allButFirstDo: [ :eachWord | s << eachWord capitalized ] ]
]

{ #category : 'construction' }
OPUmlAttributeController >> registerModelInContainer: aClass [

	aClass ownedAttributes add: model
]

{ #category : 'removing' }
OPUmlAttributeController >> removeDiagramElement [

	self diagramElement ifNotExists: [ ^ self ].
	self ownerDiagramElement ifExists: [ :owner |
		owner removeAttribute: self diagramElement ].
	self diagramElement: OPNoShape new
]

{ #category : 'removing' }
OPUmlAttributeController >> removeModel [
	"could be any of those, so just nil all of them"

	model owningAssociation: nil.
	super removeModel
]

{ #category : 'accessing' }
OPUmlAttributeController >> typeNamed: aName [
	OPUMLXMISpecsStorage primitivesMap at: aName ifPresent: [ :prim | ^ prim ].
	(diagramController model packagedElements select: [ :each | each oclIsKindOf: #Type ])
		detect: [ :each | each name = aName ]
		ifFound: [ :type | ^ type ].
	^ OPUMLClass new name: aName
]

{ #category : 'validation' }
OPUmlAttributeController >> validate [

	super validate.
	model ifNil: [ ^ self ].
	(model owningClass isNotNil and: [ model owningAssociation isNotNil ])
		ifTrue: [
			OPModelInvalid signal: (String streamContents: [ :s |
					 s << 'Property "' << model name asString << '" owned by class "'
					 << model owningClass name asString
					 << '" is also owned by assoc. '.
					 model owningAssociation name
						 ifNil: [
							 model owningAssociation memberEnds
								 do: [ :each |
									 each type ifNotNil: [ :type | s << '"' << type name << '"' ] ]
								 separatedBy: [ s << ' <-> ' ] ]
						 ifNotNil: [ :assName | s << '"' << assName << '"' ] ]) ].
	model owningAssociation: nil
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
