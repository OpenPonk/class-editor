Class {
	#name : #OPUmlNavigatorAdapter,
	#superclass : #OPNavigatorAdapter,
	#instVars : [
		'suffixMapping'
	],
	#category : 'OpenPonk-ClassEditor-Plugin'
}

{ #category : #accessing }
OPUmlNavigatorAdapter >> childrenMapping [
	^ {
	OPProject -> { #a. #b }.
	OPUMLPackage -> #packagedElements.
	OPUMLProfile -> #packagedElements.
	OPUMLModel -> #packagedElements.
	OPUMLClass -> [ :cls | cls ownedAttributes asArray , cls ownedOperations asArray ].
	OPUMLEnumeration -> #ownedLiterals}
]

{ #category : #accessing }
OPUmlNavigatorAdapter >> classNameFor: anObject [
	^ anObject umlClassName
]

{ #category : #accessing }
OPUmlNavigatorAdapter >> contextMenuMapping [
	^ {[ :obj | obj oclIsKindOf: #Package ]
		->
			{'Export as XMI...' -> [ :pkg | OPUmlClassEditorPlugin exportPackage: pkg ].
			'Import from XMI...' -> [ :pkg | OPUmlClassEditorPlugin importToPackage: pkg ]}.
	[ :obj | obj oclIsKindOf: #Profile ]
		-> {'Generate...' -> [ :pkg | OPUmlProfileGeneratorWizard openOn: pkg ]}}
]

{ #category : #accessing }
OPUmlNavigatorAdapter >> displayFor: anObject [
	^ ((self mappingFor: anObject in: self retrieveDisplayMapping)
		ifNil: [ '' ]
		ifNotNil: [ :name | name ]) , (self suffixFor: anObject)
]

{ #category : #accessing }
OPUmlNavigatorAdapter >> displayMapping [
	^ {OPUMLElement -> #name}
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
