"
I am a collection of magritte descriptions for an association end.
"
Class {
	#name : #OPUmlPropertyMagritteDescriptions,
	#superclass : #Object,
	#instVars : [
		'labelPrefix',
		'reader'
	],
	#category : #'OpenPonk-ClassEditor-Forms'
}

{ #category : #'instance creation' }
OPUmlPropertyMagritteDescriptions class >> reader: aBlock labelPrefix: aLabelPrefix [
	^ self new
		setReader: aBlock labelPrefix: aLabelPrefix;
		yourself
]

{ #category : #accessing }
OPUmlPropertyMagritteDescriptions >> descriptionAccessor: aSymbol [
	^ MAPluggableAccessor
		read: [ :me | (reader value: me) perform: aSymbol ]
		write: [ :me :newValue | 
			(reader value: me) perform: (aSymbol , ':') asSymbol with: newValue.
			me ifNotNil: [ me refreshFigure ] ]
]

{ #category : #descriptions }
OPUmlPropertyMagritteDescriptions >> descriptionAggregation [

	<magritteDescription>
	| property association isDependentOnMultiplicity |
	property := reader value: reader receiver.
	association := property association.
	isDependentOnMultiplicity := association appliedStereotypes 
		                             anySatisfy: [ :any | 
		                             any oclIsKindOf: #SubQuantityOf ].
	^ MASingleOptionDescription new
		  visible: true "isDependentOnMultiplicity not";
		  optionsAndLabels: { 
				  (OPUMLAggregationKind none -> 'none').
				  (OPUMLAggregationKind shared -> 'shared').
				  (OPUMLAggregationKind composite -> 'composite') };
		  reference: MAStringDescription new;
		  accessor: (self descriptionAccessor: #aggregation);
		  label: 'Aggregation';
		  priority: 3;
		  beSorted;
		  yourself
]

{ #category : #descriptions }
OPUmlPropertyMagritteDescriptions >> descriptionDefaultValue [

	<magritteDescription>
	^ MAStringDescription new
		  accessor: (self descriptionAccessor: #defaultValue);
		  accessor: (MAPluggableAccessor
				   read: [ :me | 
					   (reader value: me) defaultValue ifNil: [ '' ] ifNotNil: [ 
							   ((reader value: me) defaultValue isKindOf:
									    OPUMLOpaqueExpression)
								   ifTrue: [ (reader value: me) defaultValue bodies first ]
								   ifFalse: [ '' ] ] ]
				   write: [ :me :newValue | 
					   (reader value: me) defaultValue ifNil: [ 
							   (reader value: me) defaultValue: OPUMLOpaqueExpression new ].
					   ((reader value: me) defaultValue isKindOf:
							    OPUMLOpaqueExpression) ifTrue: [ 
							   (reader value: me) defaultValue bodies:
									   (newValue ifEmpty: [ {  } ] ifNotEmpty: [ { newValue } ]) ].
					   me refreshFigure ]);
		  label: labelPrefix , 'Default Value';
		  priority: 42;
		  yourself
]

{ #category : #descriptions }
OPUmlPropertyMagritteDescriptions >> descriptionIsDerived [
	<magritteDescription>
	^ MABooleanDescription new
		accessor: (self descriptionAccessor: #isDerived);
		label: 'Is Derived';
		priority: 15;
		yourself
]

{ #category : #descriptions }
OPUmlPropertyMagritteDescriptions >> descriptionIsNavigable [
	<magritteDescription>
	^ MABooleanDescription new
		accessor:
			(MAPluggableAccessor
				read: [ :me | (reader value: me) isNavigable ]
				write: [ :me :newValue | 
					me writeNavigability: newValue to: (reader value: me).
					me refreshFigure ]);
		label: 'Is Navigable';
		priority: 10;
		yourself
]

{ #category : #descriptions }
OPUmlPropertyMagritteDescriptions >> descriptionIsOrdered [
	<magritteDescription>
	^ MABooleanDescription new
		accessor: (self descriptionAccessor: #isOrdered);
		label: 'Is Ordered';
		priority: 35;
		yourself
]

{ #category : #descriptions }
OPUmlPropertyMagritteDescriptions >> descriptionIsReadOnly [
	<magritteDescription>
	^ MABooleanDescription new
		accessor: (self descriptionAccessor: #isReadOnly);
		label: 'Is Read Only';
		priority: 14;
		yourself
]

{ #category : #descriptions }
OPUmlPropertyMagritteDescriptions >> descriptionIsStatic [
	<magritteDescription>
	^ MABooleanDescription new
		accessor: (self descriptionAccessor: #isStatic);
		label: 'Is Static';
		priority: 11;
		yourself
]

{ #category : #descriptions }
OPUmlPropertyMagritteDescriptions >> descriptionIsUnique [
	<magritteDescription>
	^ MABooleanDescription new
		accessor: (self descriptionAccessor: #isUnique);
		label: 'Is Unique';
		priority: 36;
		yourself
]

{ #category : #descriptions }
OPUmlPropertyMagritteDescriptions >> descriptionMultiplicity [

	<magritteDescription>
	^ MASingleOptionDescription new
		  beExtensible;
		  options: #( '0..1' '1..1' '0..*' '1..*' );
		  reference: MAStringDescription new;
		  accessor: (MAPluggableAccessor
				   read: [ :me | 
					   (reader value: me) lowerBound asString , '..'
					   , (reader value: me) upperBound asString ]
				   write: [ :me :newValue | 
					   me writeMultiplicityFrom: newValue to: (reader value: me).
					   me diagramElement updateRenderFromModel ]);
		  label: 'Multiplicity';
		  priority: 9;
		  beSorted;
		  yourself
]

{ #category : #descriptions }
OPUmlPropertyMagritteDescriptions >> descriptionName [
	<magritteDescription>
	^ MAStringDescription new
		accessor: (self descriptionAccessor: #name);
		label: 'Name';
		priority: 2;
		yourself
]

{ #category : #descriptions }
OPUmlPropertyMagritteDescriptions >> descriptionType [
	<magritteDescription>
	^ MAStringDescription new
		beReadOnly;
		accessor:
			(MAPluggableAccessor
				read: [ :me | (reader value: me) type name ]
				write: [ :me :newValue |  ]);
		label: labelPrefix;
		priority: 1;
		yourself
]

{ #category : #descriptions }
OPUmlPropertyMagritteDescriptions >> descriptionVisibility [
	<magritteDescription>
	^ MASingleOptionDescription new
		optionsAndLabels:
			{nil -> ''.
			OPUMLVisibilityKind public -> 'public'.
			OPUMLVisibilityKind protected -> 'protected'.
			OPUMLVisibilityKind private -> 'private'.
			OPUMLVisibilityKind new package -> 'package'};
		reference: MAStringDescription new;
		accessor: (self descriptionAccessor: #visibility);
		label: 'Visibility';
		priority: 8;
		beSorted;
		yourself
]

{ #category : #initialization }
OPUmlPropertyMagritteDescriptions >> setReader: aModelReader labelPrefix: aLabelPrefix [
	reader := aModelReader.
	labelPrefix := aLabelPrefix
]
