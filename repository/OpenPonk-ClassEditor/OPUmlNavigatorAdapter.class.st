Class {
	#name : 'OPUmlNavigatorAdapter',
	#superclass : 'OPNavigatorAdapter',
	#instVars : [
		'suffixMapping'
	],
	#category : 'OpenPonk-ClassEditor-Plugin',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Plugin'
}

{ #category : 'accessing' }
OPUmlNavigatorAdapter class >> priority [

	^ 10
]

{ #category : 'accessing' }
OPUmlNavigatorAdapter >> childrenMapping [

	^ { 
		  (OPUMLPackage -> [ :package | 
		   package packagedElements
		   , (package packagedElements flatCollect: [ :each | 
				    (each respondsTo: #generalizations)
					    ifTrue: [ each generalizations ]
					    ifFalse: [ #(  ) ] ]) ]).
		  (OPUMLProfile -> #packagedElements).
		  (OPUMLClass
		   -> [ :cls | 
		   cls ownedAttributes asArray , cls ownedOperations asArray ]).
		  (OPUMLEnumeration -> #ownedLiterals).
		  (OPUMLAssociation -> [ :assoc | assoc ownedEnds asArray ]).
		  (OPUMLExtension -> [ :assoc | assoc ownedEnds asArray ]) }
]

{ #category : 'accessing' }
OPUmlNavigatorAdapter >> classNameFor: anObject [
	^ anObject umlClassName
]

{ #category : 'accessing' }
OPUmlNavigatorAdapter >> contextMenuMapping [
	^ super contextMenuMapping
		,
			{([ :obj | obj oclIsKindOf: #Package ]
				->
					{('Export as XMI...'
						-> [ :pkg | OPUmlClassEditorPlugin exportPackage: pkg ]).
					('Import from XMI...'
						-> [ :pkg | OPUmlClassEditorPlugin importToPackage: pkg ])}).
			([ :obj | obj oclIsKindOf: #Profile ]
				-> {('Generate...' -> [ :pkg | OPUmlProfileGeneratorWizard openOn: pkg ])})}
]

{ #category : 'accessing' }
OPUmlNavigatorAdapter >> dependentMapping [
	| mainElementTypes packageLikeBlock |
	mainElementTypes := {#Class . #Package . #Enumeration . #Profile.
	#Model}.
	packageLikeBlock := [ :object :rootModel | 
	(object packagedElements
		select:
			[ :each | mainElementTypes anySatisfy: [ :any | each oclIsKindOf: any ] ])
		, object packageImports
		,
			((rootModel packagedElements
				select: [ :each | 
					{#Package . #Profile . #Model}
						anySatisfy: [ :any | each oclIsKindOf: any ] ])
				flatCollectAsSet: [ :eachPackagedElement | 
					eachPackagedElement packageImports
						select: [ :eachImport | eachImport importingNamespace = object ] ]) ].
	^ {(OPUMLPackage -> packageLikeBlock).
	(OPUMLProfile -> packageLikeBlock).
	(OPUMLClass
		-> [ :class :model | 
			class ownedAttributes asSet , class ownedOperations asSet
				, class generalizations asSet
				,
					((model packagedElements
						select:
							[ :eachPackageElement | eachPackageElement oclIsKindOf: #GeneralizationSet ])
						flatCollectAsSet: [ :eachSet | 
							eachSet generalizations
								select: [ :eachGeneralization | 
									eachGeneralization general = class
										or: [ eachGeneralization specific = class ] ] ])
				,
					((model packagedElements
						select: [ :eachPackageElement | eachPackageElement oclIsKindOf: #Class ])
						flatCollectAsSet: [ :eachClass | 
							eachClass generalizations
								select: [ :eachGeneralization | 
									eachGeneralization general = class
										or: [ eachGeneralization specific = class ] ] ])
				,
					(model packagedElements
						select: [ :eachAssoc | 
							(eachAssoc oclIsKindOf: #Association)
								and: [ eachAssoc memberEnds
										anySatisfy: [ :any | any type = class or: [ any owningClass = class ] ] ] ]) ]).
	(OPUMLEnumeration -> #ownedLiterals)}
]

{ #category : 'accessing' }
OPUmlNavigatorAdapter >> displayFor: anObject [
	^ ((self mappingFor: anObject in: self retrieveDisplayMapping)
		ifNil: [ '' ]
		ifNotNil: [ :name | name ]) , (self suffixFor: anObject)
]

{ #category : 'accessing' }
OPUmlNavigatorAdapter >> displayMapping [

	^ {
		  (OPUMLAssociation -> [ :a |
		   String streamContents: [ :s |
			   a name ifNotNil: [ :name | s << name ].
			   a memberEnds size = 2 ifTrue: [
				   | names |
				   names := a memberEnds asArray collect: [ :property |
					            ((property type ifNotNil: [ :type | type name ])
						             ifNil: [ '' ]) truncateWithElipsisTo: 20 ].
				   s << ' [ '.
				   names printOn: s delimiter: ' -> '.
				   s << ' ]' ] ] ]).
		  (OPUMLGeneralization
		   -> [ :o | o specific name , ' => ' , o general name ]).
		  (OPUMLPackageImport
		   -> [ :o |
		   o importedPackage name , ' --> ' , o importingNamespace name ]).
		  (OPUMLElement -> #name) }
]

{ #category : 'accessing' }
OPUmlNavigatorAdapter >> hasMappingFor: anObject in: aModel [

	| appliedStereotypeNames availableStereotypeNames |
	(anObject isKindOf: OPUMLMetaElement) ifFalse: [ ^ false ].
	(aModel respondsTo: #profileApplications) ifFalse: [ ^ true ].
	appliedStereotypeNames := anObject appliedStereotypes collect:
		                          #umlClassName.
	appliedStereotypeNames ifEmpty: [ ^ true ].
	availableStereotypeNames := aModel profileApplications 
		                            flatCollectAsSet: [ 
			                            :eachProfileApplication | 
			                            eachProfileApplication appliedProfile
				                            ownedStereotype collect: [ 
				                            :eachStereotype | eachStereotype name ] ].
	^ appliedStereotypeNames allSatisfy: [ :each | 
		  availableStereotypeNames includes: each ]
]

{ #category : 'accessing' }
OPUmlNavigatorAdapter >> iconMapping [
	^ {OPUMLProfile -> OPUmlIcons profileIcon.
	OPUMLPackage -> OPUmlIcons packageIcon.
	OPUMLClass -> OPUmlIcons classIcon.
	OPUMLDataType -> OPUmlIcons dataTypeIcon.
	OPUMLPrimitiveType -> OPUmlIcons primitiveIcon.
	OPUMLEnumeration -> OPUmlIcons enumIcon.
	OPUMLEnumerationLiteral -> OPUmlIcons literalIcon.
	OPUMLProperty -> OPUmlIcons attributeIcon.
	OPUMLOperation -> OPUmlIcons operationIcon.
	OPUMLConstraint -> OPUmlIcons constraintIcon.
	OPUMLAssociation -> OPUmlIcons directedAssociationIcon.
	OPUMLExtension -> OPUmlIcons extensionIcon.
	OPUMLGeneralization -> OPUmlIcons generalizationIcon.
	OPUMLStereotype -> OPUmlIcons stereotypeIcon.
	OPUMLComment -> OPUmlIcons commentIcon.
	Object -> OPUmlIcons unknownIcon}
]

{ #category : 'cache' }
OPUmlNavigatorAdapter >> retrieveSuffixMapping [
	^ suffixMapping ifNil: [ suffixMapping := self suffixMapping asDictionary ]
]

{ #category : 'private' }
OPUmlNavigatorAdapter >> sort: modelObjects [

	^ modelObjects sorted: [ :a :b | 
		  ((a respondsTo: #name) and: [ 
			   (b respondsTo: #name) and: [ 
				   a name isNotNil or: [ b name isNotNil ] ] ])
			  ifTrue: [ 
			  a name isNotNil and: [ b name isNil or: [ a name < b name ] ] ]
			  ifFalse: [ a uuid < b uuid ] ]
]

{ #category : 'accessing' }
OPUmlNavigatorAdapter >> suffixFor: anObject [
	^ (self mappingFor: anObject in: self retrieveSuffixMapping)
		ifNil: [ '' ]
		ifNotNil: [ :suffix | ' (' , suffix , ')' ]
]

{ #category : 'accessing' }
OPUmlNavigatorAdapter >> suffixMapping [
	^ {OPUMLMetaElement -> [ :o | self classNameFor: o ]}
]

{ #category : 'widget API' }
OPUmlNavigatorAdapter >> typesByDependency [
	^ {OPUMLPackage.
	OPUMLProfile.
	OPUMLClass.
	OPUMLStereotype.
	OPUMLEnumeration.
	OPUMLPackageImport.
	OPUMLAssociation.
	OPUMLGeneralizationSet.
	OPUMLGeneralization.
	OPUMLOperation.
	OPUMLEnumerationLiteral.
	OPUMLProperty}
]
