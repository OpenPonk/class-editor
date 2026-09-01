"
I am the ViewModel for UML Properties (attributes) belonging to a UML Class. I manage properties like types, multiplicity, default values, uniqueness, and navigability representations in the Magritte forms.
"
Class {
	#name : 'OPUmlClassPropertyViewModel',
	#superclass : 'OPUmlClassItemViewModel',
	#category : 'OpenPonk-ClassEditor-ViewModels',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'ViewModels'
}

{ #category : 'accessing' }
OPUmlClassPropertyViewModel class >> modelClass [ ^ OPUMLProperty
]

{ #category : 'private' }
OPUmlClassPropertyViewModel >> basicRemoveModel [

	self model owningAssociation: nil.
	self model association: nil.
	super basicRemoveModel
]

{ #category : 'construction' }
OPUmlClassPropertyViewModel >> createModelIn: aClass [

	^ (super createModelIn: aClass)
		  name: self placeholderName;
		  yourself
]

{ #category : 'accessing' }
OPUmlClassPropertyViewModel >> dependingOnElements [

	| asSetOrEmpty |
	asSetOrEmpty := [ :nullableElement |
	                nullableElement
		                ifNil: [ Set empty ]
		                ifNotNil: [ :element | Set with: element ] ].

	^ super dependingOnElements
	  , (asSetOrEmpty value: self model owningAssociation)
]

{ #category : 'forms' }
OPUmlClassPropertyViewModel >> descriptionDefaultValue [

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
					   self modelChanged ]);
		  label: 'Default Value';
		  priority: 42;
		  yourself
]

{ #category : 'forms' }
OPUmlClassPropertyViewModel >> descriptionIsDerived [
	<magritteDescription>
	^ MABooleanDescription new
		accessor: (self descriptionAccessor: #isDerived);
		label: 'Is Derived';
		priority: 15;
		yourself
]

{ #category : 'forms' }
OPUmlClassPropertyViewModel >> descriptionIsOrdered [
	<magritteDescription>
	^ MABooleanDescription new
		accessor: (self descriptionAccessor: #isOrdered);
		label: 'Is Ordered';
		priority: 35;
		yourself
]

{ #category : 'forms' }
OPUmlClassPropertyViewModel >> descriptionIsReadOnly [
	<magritteDescription>
	^ MABooleanDescription new
		accessor: (self descriptionAccessor: #isReadOnly);
		label: 'Is Read Only';
		priority: 14;
		yourself
]

{ #category : 'forms' }
OPUmlClassPropertyViewModel >> descriptionIsUnique [
	<magritteDescription>
	^ MABooleanDescription new
		accessor: (self descriptionAccessor: #isUnique);
		label: 'Is Unique';
		priority: 36;
		yourself
]

{ #category : 'forms' }
OPUmlClassPropertyViewModel >> descriptionMultiplicity [

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
					   self modelChanged ]);
		  label: 'Multiplicity';
		  priority: 9;
		  beSorted;
		  yourself
]

{ #category : 'forms' }
OPUmlClassPropertyViewModel >> descriptionType [

	<magritteDescription>
	| description writeBlock |
	description := MAStringDescription new.
	writeBlock := self model association
		              ifNotNil: [
			              description beReadOnly.
			              [ :me :newValue |  ] ]
		              ifNil: [
			              [ :me :newValue |
			              newValue
				              ifEmpty: [ me model type: nil ]
				              ifNotEmpty: [
				              me model type: (self typeNamed: newValue) ].
			              self modelChanged ] ].
	description
		accessor: (MAPluggableAccessor
				 read: [ :me |
					 me model type ifNil: [ '' ] ifNotNil: [ :type | type name ] ]
				 write: writeBlock);
		label: 'Type';
		priority: 5.
	^ description
]

{ #category : 'accessing' }
OPUmlClassPropertyViewModel >> findParentViewModel [
    self model owningClass ifNotNil: [ :m | ^ self registry viewModelFor: m ].
    self model owningAssociation ifNotNil: [ :m | ^ self registry viewModelFor: m ].
    self model datatype ifNotNil: [ :m | ^ self registry viewModelFor: m ].
    ^ super findParentViewModel
]

{ #category : 'accessing' }
OPUmlClassPropertyViewModel >> icon [ ^ OPUmlIcons attributeIcon
]

{ #category : 'accessing' }
OPUmlClassPropertyViewModel >> placeholderName [

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
OPUmlClassPropertyViewModel >> registerModelIn: aClass [

	aClass ownedAttributes add: self model
]

{ #category : 'forms' }
OPUmlClassPropertyViewModel >> typeNamed: aName [

	OPUMLXMISpecsStorage primitivesMap
		at: aName
		ifPresent: [ :prim | ^ prim ].
	self modelRootViewModel allTypeElements
		detect: [ :each | each name = aName ]
		ifFound: [ :type | ^ type ].
	^ OPUMLClass new name: aName
]

{ #category : 'validation' }
OPUmlClassPropertyViewModel >> validate [

	super validate.
	self validateProperty: self model
]

{ #category : 'parsing' }
OPUmlClassPropertyViewModel >> writeMultiplicityFrom: aString to: aProperty [
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
