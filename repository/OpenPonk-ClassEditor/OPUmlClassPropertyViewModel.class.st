"
I am the ViewModel for UML Properties (attributes) belonging to a UML Class. I manage properties like types, multiplicity, default values, uniqueness, and navigability representations in the Magritte forms.
"
Class {
	#name : 'OPUmlClassPropertyViewModel',
	#superclass : 'OPUmlClassItemViewModel',
	#instVars : [
		'savedAssociation'
	],
	#category : 'OpenPonk-ClassEditor-ViewModels',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'ViewModels'
}

{ #category : 'accessing' }
OPUmlClassPropertyViewModel class >> modelClass [ ^ OPUMLProperty
]

{ #category : 'accessing' }
OPUmlClassPropertyViewModel >> availableTypeNames [
	| names |
	names := Set new.
	(Smalltalk globals at: #OPUMLXMISpecsStorage ifPresent: [ :storage |
		names addAll: storage primitivesMap keys ]).
	(self respondsTo: #establishedTypeNames) ifTrue: [
		names addAll: self establishedTypeNames ].
	self modelRootViewModel ifNotNil: [ :rootViewModel |
		(rootViewModel respondsTo: #allTypeElements) ifTrue: [
			names addAll: (rootViewModel allTypeElements collect: #name thenSelect: #isNotNil) ] ].
	^ (names asArray sorted: [ :a :b | a <= b ])
]

{ #category : 'removing' }
OPUmlClassPropertyViewModel >> basicRemoveModel [
	savedAssociation := self model association.
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

{ #category : 'magritte-descriptions' }
OPUmlClassPropertyViewModel >> descriptionType [
	<magritteDescription>
	| description writeBlock completion isAssociationEnd |
	description := MAStringDescription new.

	isAssociationEnd := self model isNotNil and: [
		(self model respondsTo: #association) and: [ self model association isNotNil ] ].

	writeBlock := isAssociationEnd
		ifTrue: [
			description beReadOnly.
			[ :me :newValue | ] ]
		ifFalse: [
			[ :me :newValue |
			me model ifNotNil: [ :targetModel |
				newValue
					ifEmpty: [ targetModel type: nil ]
					ifNotEmpty: [ targetModel type: (self typeNamed: newValue) ].
				self modelRootViewModel ifNotNil: [ :rootViewModel |
					rootViewModel model ifNotNil: [ :rootModel |
						OPUmlCommonTypesFactory removeUnusedTypesFrom: rootModel ] ].
				self modelChanged ] ] ].

	description
		accessor: (MAPluggableAccessor
			read: [ :me |
				(me model isNotNil and: [ me model type isNotNil ])
					ifTrue: [ me model type name ]
					ifFalse: [ '' ] ]
			write: writeBlock);
		label: 'Type';
		priority: 5.

	completion := EntryCompletion new.
	completion dataSourceBlock: [ :currText |
		| token allNames prefixMatches substringMatches combinedMatches |
		token := currText asString trimBoth.
		token ifEmpty: [ #() ] ifNotEmpty: [
			allNames := self availableTypeNames.
			prefixMatches := (allNames select: [ :each |
				each beginsWith: token caseSensitive: false ]) asSortedCollection asArray.
			substringMatches := (allNames select: [ :each |
				(each includesSubstring: token caseSensitive: false)
					and: [ (prefixMatches includes: each) not ] ]) asSortedCollection asArray.
			combinedMatches := prefixMatches , substringMatches.
			combinedMatches first: (combinedMatches size min: 30) ] ].

	completion filterBlock: [ :candidate :token |
		| cleanToken isTemporaryCandidate |
		cleanToken := token asString trimBoth.
		cleanToken isNotEmpty and: [
			isTemporaryCandidate := (candidate = cleanToken) and: [ (self establishedTypeNames includes: candidate) not ].
			isTemporaryCandidate not and: [
				candidate includesSubstring: cleanToken caseSensitive: false ] ] ].

	description propertyAt: #entryCompletion put: completion.
	^ description
]

{ #category : 'accessing' }
OPUmlClassPropertyViewModel >> establishedTypeNames [
	| names rootModel |
	names := Set new.
	names addAll: OPUMLXMISpecsStorage primitivesMap keys.
	names addAll: OPUmlCommonTypesFactory typeNames.
	self modelRootViewModel ifNotNil: [ :rootViewModel |
		rootModel := rootViewModel model.
		rootModel ifNotNil: [
			(rootModel respondsTo: #packagedElements) ifTrue: [
				rootModel packagedElements do: [ :each |
					(each oclIsKindOf: #Class) ifTrue: [ names add: each name ].
					(each oclIsKindOf: #Enumeration) ifTrue: [ names add: each name ] ] ] ] ].
	^ names
]

{ #category : 'accessing' }
OPUmlClassPropertyViewModel >> findParentViewModel [
	self registry ifNil: [ ^ nil ].
	self model ifNil: [ ^ nil ].
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
OPUmlClassPropertyViewModel >> registerModelIn: aParentModel [
	(aParentModel respondsTo: #ownedAttributes)
		ifTrue: [
			aParentModel ownedAttributes add: self model.
			savedAssociation ifNotNil: [ :assoc | self model association: assoc ].
			^ self ].
	(aParentModel respondsTo: #ownedEnds)
		ifTrue: [
			self model owningAssociation: aParentModel.
			(aParentModel memberEnds includes: self model)
				ifFalse: [ aParentModel memberEnds add: self model ].
			^ self ].
	AssertionFailure signal: 'Unsupported parent model: ' , aParentModel printString
]

{ #category : 'accessing' }
OPUmlClassPropertyViewModel >> typeNamed: aName [
	| rootModel commonTypesPackage newDataType |
	OPUMLXMISpecsStorage primitivesMap
		at: aName
		ifPresent: [ :primitiveType | ^ primitiveType ].
	self modelRootViewModel allTypeElements
		detect: [ :each | each name = aName ]
		ifFound: [ :foundType | ^ foundType ].
	rootModel := self modelRootViewModel ifNotNil: [ :viewModel | viewModel model ].
	(rootModel isNotNil and: [ rootModel respondsTo: #packagedElements ]) ifTrue: [
		commonTypesPackage := rootModel packagedElements
			detect: [ :each | (each oclIsKindOf: #Package) and: [ each name = OPUmlCommonTypesFactory commonTypesPackageName ] ]
			ifNone: [
				| createdPackage |
				createdPackage := OPUmlCommonTypesFactory new commonTypesPackage.
				rootModel packagedElements add: createdPackage.
				createdPackage ].
		commonTypesPackage packagedElements
			detect: [ :each | each name = aName ]
			ifFound: [ :existingType | ^ existingType ].
		newDataType := OPUMLDataType new.
		newDataType name: aName.
		commonTypesPackage packagedElements add: newDataType.
		^ newDataType ].
	newDataType := OPUMLDataType new.
	newDataType name: aName.
	^ newDataType
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
