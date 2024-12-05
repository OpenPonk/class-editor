Trait {
	#name : 'OPTUmlBaseController',
	#category : 'OpenPonk-ClassEditor-Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Controllers'
}

{ #category : 'forms' }
OPTUmlBaseController >> descriptionAccessor: aSymbol [

	^ MAPluggableAccessor
		  read: [ :me | me model perform: aSymbol ]
		  write: [ :me :newValue |
			  me model perform: (aSymbol , ':') asSymbol with: newValue.
			  self modelChanged ]
]

{ #category : 'forms' }
OPTUmlBaseController >> descriptionComment [

	<magritteDescription>
	^ MAMemoDescription new
		  required: false;
		  accessor: (MAPluggableAccessor
				   read: [ :me |
					   me model ownedComments
						   ifEmpty: [ '' ]
						   ifNotEmpty: [ :oc | oc first body asString ] ]
				   write: [ :me :newValue |
					   newValue asString
						   ifEmpty: [ me model ownedComments: OrderedCollection new ]
						   ifNotEmpty: [
							   me model ownedComments ifEmpty: [
									   me model ownedComments add: OPUMLComment new ].
							   me model ownedComments first body: newValue asString ].
					   self modelChanged ]);
		  label: 'Comment';
		  priority: 100;
		  lineCount: 10;
		  yourself
]

{ #category : 'forms' }
OPTUmlBaseController >> descriptionModelInfo [
	<magritteDescription>
	^ MAStringDescription new
		beReadOnly;
		accessor: (MAPluggableAccessor read: [ :me | '' ] write: [ :me :newValue |  ]);
		label: self nameOfType;
		priority: 0;
		yourself
]

{ #category : 'forms' }
OPTUmlBaseController >> descriptionName [
	<magritteDescription>
	^ MAStringDescription new
		accessor: (self descriptionAccessor: #name);
		label: 'Name';
		priority: 1;
		yourself
]

{ #category : 'forms' }
OPTUmlBaseController >> descriptionVisibility [

	<magritteDescription>
	^ MASingleOptionDescription new
		  optionsAndLabels: {
				  (nil -> '').
				  (OPUMLVisibilityKind public -> 'public').
				  (OPUMLVisibilityKind protected -> 'protected').
				  (OPUMLVisibilityKind private -> 'private').
				  (OPUMLVisibilityKind new package -> 'package') };
		  reference: MAStringDescription new;
		  accessor: (MAPluggableAccessor
				   read: [ :me | me model visibility ]
				   write: [ :me :newValue |
					   me model visibility: newValue.
					   self modelChanged ]);
		  label: 'Visibility';
		  priority: 8;
		  beSorted;
		  yourself
]

{ #category : 'validation' }
OPTUmlBaseController >> validateProperty: aProperty [

	aProperty ifNil: [ ^ self ].
	(aProperty association isNotNil and: [
		 (aProperty type respondsTo: #oclIsKindOf:) not or: [
			 (aProperty type oclIsKindOf: #Classifier) not ] ]) ifTrue: [
		self validationFailedAssociationPropertyWithoutClassifierType:
			aProperty ].
	aProperty owningAssociation
		ifNil: [
			aProperty owningClass ifNil: [
				self validationFailedPropertyWithoutOwner: aProperty ] ]
		ifNotNil: [
			aProperty owningClass ifNotNil: [
				self validationFailedPropertyWithTwoOwners: aProperty ] ]
]

{ #category : 'validation' }
OPTUmlBaseController >> validationFailedAssociationPropertyWithoutClassifierType: aProperty [

	OPModelInvalid signal: (String streamContents: [ :s |
			 s << 'Property "' << aProperty name asString << '" has type '
			 << aProperty type asString << ' although it is part of '
			 << aProperty association asString ]).

	"Try to use opposite owningClass as type"
	aProperty opposite owningClass ifNotNil: [ :oppositeOwner |
		aProperty type: oppositeOwner ]

	"No way to fix this - the association end information is lost"
]

{ #category : 'validation' }
OPTUmlBaseController >> validationFailedPropertyWithTwoOwners: aProperty [

	OPModelInvalid signal: (String streamContents: [ :s |
			 s << 'Property "' << aProperty name asString << '" owned by '
			 << aProperty owningClass asString << ' is also owned by '
			 << aProperty owningAssociation asString ]).

	"Remove the ownership by the association in order to load the model"
	aProperty owningAssociation: nil
]

{ #category : 'validation' }
OPTUmlBaseController >> validationFailedPropertyWithoutOwner: aProperty [

	OPModelInvalid signal: (String streamContents: [ :s |
			 s << 'Property "' << aProperty name asString << '" with type '
			 << aProperty type asString << ' has no owner' ]).

	"Attempt to create an ownership if possible"
	aProperty type ifNil: [ ^ self ].
	(self diagramController allModelElementsWithPossibleController includes: aProperty type)
		ifFalse: [ ^ self ].
	aProperty owningClass: aProperty type
]
