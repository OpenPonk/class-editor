"
I am the abstract base ViewModel for all UML elements in the class editor. I handle structural lookups (like finding the owning package hierarchy), stereotype application logic, and provide standard Magritte descriptions (name, visibility, comments) for the UI forms.
"
Class {
	#name : 'OPUmlElementViewModel',
	#superclass : 'OPViewModel',
	#category : 'OpenPonk-ClassEditor-ViewModels',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'ViewModels'
}

{ #category : 'accessing' }
OPUmlElementViewModel class >> commonModelClassPrefix [

	^ 'OPUML'
]

{ #category : 'testing' }
OPUmlElementViewModel class >> isAbstract [

	^ self = OPUmlElementViewModel
]

{ #category : 'accessing' }
OPUmlElementViewModel class >> modelClass [ ^ OPUMLElement
]

{ #category : 'enumerating' }
OPUmlElementViewModel >> allTypeElements [

	^ Set empty
]

{ #category : 'stereotypes' }
OPUmlElementViewModel >> applyStereotype: aStereotypeModel to: aModel [
	(aModel appliedStereotypes
		anySatisfy: [ :each | each umlClassName = aStereotypeModel umlClassName ])
		ifTrue: [ ^ self ].
	self removeStereotypesIn: aModel.
	aModel applyStereotype: aStereotypeModel implementationClass new
]

{ #category : 'ui-hooks' }
OPUmlElementViewModel >> creationUICommandClass [

	^ OPRenameElementCommand
]

{ #category : 'forms' }
OPUmlElementViewModel >> descriptionComment [
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
OPUmlElementViewModel >> descriptionModelInfo [
	<magritteDescription>
	^ MAStringDescription new
		beReadOnly;
		accessor: (MAPluggableAccessor read: [ :me | '' ] write: [ :me :newValue |  ]);
		label: self nameOfType;
		priority: 0;
		yourself
]

{ #category : 'forms' }
OPUmlElementViewModel >> descriptionName [
	<magritteDescription>
	^ MAStringDescription new
		accessor: (self descriptionAccessor: #name);
		label: 'Name';
		priority: 1;
		yourself
]

{ #category : 'forms' }
OPUmlElementViewModel >> descriptionStereotypeContent [

	| names stereotypes |
	stereotypes := self modelRootViewModel model profileApplications
		               ifEmpty: [ ^ nil ]
		               ifNotEmpty: [ :applications |
				               applications flatCollect: [ :each |
					               self
						               stereotypesIn: each appliedProfile
						               for: self model ] ].
	names := stereotypes asArray collect: [ :each |
		         each name -> each name ].
	^ MASingleOptionDescription new
		  optionsAndLabels: { (nil -> '') } , names;
		  accessor: (MAPluggableAccessor
				   read: [ :me |
						   me model appliedStereotypes
							   ifEmpty: [ nil ]
							   ifNotEmpty: [ :col | col first umlClassName ] ]
				   write: [ :me :newValue |
						   newValue
							   ifNil: [ self removeStereotypesIn: me model ]
							   ifNotNil: [
									   self
										   applyStereotype:
											   (stereotypes detect: [ :each | each name = newValue ])
										   to: me model ].
						   me modelChanged ]);
		  label: 'Stereotype';
		  priority: 4;
		  yourself
]

{ #category : 'forms' }
OPUmlElementViewModel >> descriptionVisibility [
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

{ #category : 'private' }
OPUmlElementViewModel >> findOwningPackageFor: aModel [

	self registry project models
		select: [ :each | each oclIsKindOf: #Package ]
		thenDo: [ :rootPkg |
				(self findPackageHierarchyFor: aModel in: { rootPkg })
					ifNotEmpty: [ :path | ^ path last ] ].
	^ nil
]

{ #category : 'private' }
OPUmlElementViewModel >> findPackageHierarchyFor: aModel in: packagesList [
    | packagedElements |
    packagedElements := packagesList last packagedElements.
    (packagedElements identityIncludes: aModel) ifTrue: [ ^ packagesList ].
    packagedElements select: [ :each | each oclIsKindOf: #Package ] thenDo: [ :eachPkg |
        (self findPackageHierarchyFor: aModel in: (packagesList copyWith: eachPkg))
            ifNotEmpty: [ :foundList | ^ foundList ] ].
    ^ #( )
]

{ #category : 'accessing' }
OPUmlElementViewModel >> findParentViewModel [

	(self findOwningPackageFor: self model) ifNotNil: [ :pkg |
		^ self registry viewModelFor: pkg ].
	^ self registry projectViewModel
]

{ #category : 'printing' }
OPUmlElementViewModel >> modelDisplayStringOn: aStream [
    self model name ifNotEmpty: [ :n | aStream nextPutAll: n; space ].
    aStream nextPutAll: '('.
    (self model respondsTo: #appliedStereotypes)
        ifTrue: [
            self model appliedStereotypes ifNotEmpty: [ :stereotypes |
                aStream nextPutAll: stereotypes first umlClassName.
                aStream nextPutAll: ')'.
                ^ self ] ].
    aStream nextPutAll: self model umlClassName; nextPutAll: ')'
]

{ #category : 'accessing' }
OPUmlElementViewModel >> modelType [

	^ OPModelObjectType
		  named: (self model umlClassName splitCamelCase joinUsing: ' ')
		  withSubtypes: ((self model appliedStereotypes collect: [ :eachStereotype |
					    OPModelObjectType named: (String streamContents: [ :s |
								     s nextPut: $«.
								     s nextPutAll: eachStereotype umlClassName.
								     s nextPut: $» ]) ]) ifEmpty: [ { (OPModelObjectType named: '(without stereotypes)') } ])
]

{ #category : 'accessing' }
OPUmlElementViewModel >> packageViewModel [

	^ self parentViewModel ifNotNil: [ :parent |
			  parent = self registry projectViewModel ifFalse: [
				  parent packageViewModel ] ]
]

{ #category : 'accessing' }
OPUmlElementViewModel >> parentPackageViewModel [

	^ self parentViewModel ifNotNil: [ :parent |
			  parent = self registry projectViewModel ifFalse: [
				  parent packageViewModel ] ]
]

{ #category : 'stereotypes' }
OPUmlElementViewModel >> removeStereotypesIn: aModel [
	[ aModel appliedStereotypes isNotEmpty ]
		whileTrue: [ aModel unapplyStereotype: aModel appliedStereotypes first ]
]

{ #category : 'stereotypes' }
OPUmlElementViewModel >> stereotypesIn: aProfile for: aModel [
	^ (aProfile ownedStereotype reject: #isAbstract) select: [ :stereo | 
		  stereo allAttributes anySatisfy: [ :each | 
			  (each name beginsWith: 'base_') and: [ 
				  self model oclIsKindOf: each type name ] ] ]
]

{ #category : 'validation' }
OPUmlElementViewModel >> validateProperty: aProperty [
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
OPUmlElementViewModel >> validationFailedAssociationPropertyWithoutClassifierType: aProperty [
	OPModelInvalid signal: (String streamContents: [ :s |
			 s << 'Property "' << aProperty name asString << '" has type '
			 << aProperty type asString << ' although it is part of '
			 << aProperty association asString ]).
	aProperty opposite owningClass ifNotNil: [ :oppositeOwner |
		aProperty type: oppositeOwner ]
]

{ #category : 'validation' }
OPUmlElementViewModel >> validationFailedPropertyWithTwoOwners: aProperty [
	OPModelInvalid signal: (String streamContents: [ :s |
			 s << 'Property "' << aProperty name asString << '" owned by '
			 << aProperty owningClass asString << ' is also owned by '
			 << aProperty owningAssociation asString ]).
	aProperty owningAssociation: nil
]

{ #category : 'validation' }
OPUmlElementViewModel >> validationFailedPropertyWithoutOwner: aProperty [
	OPModelInvalid signal: (String streamContents: [ :s |
			 s << 'Property "' << aProperty name asString << '" with type '
			 << aProperty type asString << ' has no owner' ]).
	aProperty type ifNil: [ ^ self ].
	aProperty owningClass: aProperty type
]
