Class {
	#name : #OPUmlNavigatorAdapter,
	#superclass : #OPNavigatorAdapter,
	#instVars : [
		'suffixMapping'
	],
	#category : #'OpenPonk-ClassEditor-Plugin'
}

{ #category : #accessing }
OPUmlNavigatorAdapter >> childrenMapping [
	^ {(OPUMLPackage -> #packagedElements).
	(OPUMLProfile -> #packagedElements).
	(OPUMLModel -> #packagedElements).
	(OPUMLClass
		-> [ :cls | cls ownedAttributes asArray , cls ownedOperations asArray ]).
	(OPUMLEnumeration -> #ownedLiterals)}
]

{ #category : #accessing }
OPUmlNavigatorAdapter >> classNameFor: anObject [
	^ anObject umlClassName
]

{ #category : #accessing }
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

{ #category : #accessing }
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
	(OPUMLModel -> packageLikeBlock).
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

{ #category : #accessing }
OPUmlNavigatorAdapter >> displayFor: anObject [
	^ ((self mappingFor: anObject in: self retrieveDisplayMapping)
		ifNil: [ '' ]
		ifNotNil: [ :name | name ]) , (self suffixFor: anObject)
]

{ #category : #accessing }
OPUmlNavigatorAdapter >> displayMapping [
	^ {(OPUMLGeneralization
		-> [ :o | o specific name , ' => ' , o general name ]).
	(OPUMLPackageImport
		-> [ :o | o importedPackage name , ' --> ' , o importingNamespace name ]).
	(OPUMLElement -> #name)}
]

{ #category : #accessing }
OPUmlNavigatorAdapter >> famixClassNameFor: anObject [
	^ (anObject className splitOn: 'FAMIX') last
]

{ #category : #accessing }
OPUmlNavigatorAdapter >> hasMappingFor: anObject [
	^ anObject isKindOf: OPUMLMetaElement
]

{ #category : #accessing }
OPUmlNavigatorAdapter >> iconMapping [
	^ {OPUMLProfile -> OPUmlIcons profileIcon.
	OPUMLPackage -> OPUmlIcons packageIcon.
	OPUMLModel -> OPUmlIcons modelIcon.
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

{ #category : #cache }
OPUmlNavigatorAdapter >> retrieveSuffixMapping [
	^ suffixMapping ifNil: [ suffixMapping := self suffixMapping asDictionary ]
]

{ #category : #accessing }
OPUmlNavigatorAdapter >> suffixFor: anObject [
	^ (self mappingFor: anObject in: self retrieveSuffixMapping)
		ifNil: [ '' ]
		ifNotNil: [ :suffix | ' (' , suffix , ')' ]
]

{ #category : #accessing }
OPUmlNavigatorAdapter >> suffixMapping [
	^ {OPUMLMetaElement -> [ :o | self classNameFor: o ]}
]

{ #category : #'widget API' }
OPUmlNavigatorAdapter >> typesByDependency [
	^ {OPUMLPackage.
	OPUMLModel.
	OPUMLProfile.
	OPUMLClass.
	OPUMLEnumeration.
	OPUMLPackageImport.
	OPUMLAssociation.
	OPUMLGeneralizationSet.
	OPUMLGeneralization.
	OPUMLOperation.
	OPUMLEnumerationLiteral.
	OPUMLProperty}
]
