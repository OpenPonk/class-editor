"
I take a smalltalk code and generate a FAMIX UML model. I use my pragma annotations as well as RoelTyper (if none are present) to infer the types.
"
Class {
	#name : #DCCodeToUmlGenerator,
	#superclass : #Object,
	#instVars : [
		'category',
		'factory'
	],
	#category : 'UML-CodeGenerator-Generators'
}

{ #category : #'generator - attribute' }
DCCodeToUmlGenerator >> attributeTypeFor: aSymbol in: aClass [
	^ FAMIXClass named: (self attributeTypeNameFor: aSymbol in: aClass)
]

{ #category : #'generator - attribute' }
DCCodeToUmlGenerator >> attributeTypeNameFor: aSymbol in: aClass [
	(aClass includesSelector: aSymbol)
		ifTrue:
			[ (aClass >> aSymbol) pragmas
				detect: [ :each | each keyword = #DCType:multiplicity: | (each keyword = #DCType:) ]
				ifFound: [ :pragma | ^ pragma arguments first ] ].
	^ #Object
]

{ #category : #'generator - attribute' }
DCCodeToUmlGenerator >> createAttributeNamed: aSymbol in: aClass [
	^ FAMIXAttribute new
		name: aSymbol;
		declaredType: (self attributeTypeFor: aSymbol in: aClass);
		multiplicity: (self multiplicityFor: aSymbol in: aClass);
		yourself
]

{ #category : #'generator - class' }
DCCodeToUmlGenerator >> createClassFor: aClass [
	^ FAMIXClass new
		name: aClass name;
		yourself
]

{ #category : #'generator - method' }
DCCodeToUmlGenerator >> createMethodFor: aSelector in: aClass [
	(aClass >> aSelector) pragmas
		detect: [ :each | each keyword = #DCMethod: ]
		ifFound: [ :pragma | ^ factory method: pragma arguments first ].
	^ FAMIXMethod new
		name: aSelector;
		parameters: (self methodParametersFor: aSelector in: aClass)
]

{ #category : #'public - importer' }
DCCodeToUmlGenerator >> importFromClasses: aCollection [
	| model importer |
	model := MooseModel new.
	importer := MoosePharoImporterTask new.
	importer importingContext mergeClassAndMetaclass.
	importer runCandidateOperator.
	importer
		model: model;
		addClasses: aCollection;
		runWithProgress.
	self processPragmasFor: model.
	self processClassSide: model.
	^ model
]

{ #category : #'public - importer' }
DCCodeToUmlGenerator >> importFromPackageNamed: aPackageName [
	| model importer |
	model := MooseModel new.
	model name: aPackageName.
	importer := MoosePharoImporterTask new.
	importer importingContext mergeClassAndMetaclass.
	importer runCandidateOperator.
	importer
		model: model;
		addFromPackageNamed: aPackageName;
		runWithProgress.
	self processClassSide: model.
	self processPragmasFor: model.
	^ model
]

{ #category : #initialization }
DCCodeToUmlGenerator >> initialize [
	super initialize.
	factory := OPUmlDSLFactory new
]

{ #category : #'generator - attribute' }
DCCodeToUmlGenerator >> lowerBoundFor: aPragma [
	aPragma arguments second
		ifNotEmpty:
			[ :range | 
			^ range size = 1
				ifTrue: [ range first = '*'
						ifTrue: [ 0 ]
						ifFalse: [ range first ] ]
				ifFalse: [ range first ] ].
	^ 1
]

{ #category : #'generator - method' }
DCCodeToUmlGenerator >> methodParametersFor: aSelector in: aClass [
	^ (aClass >> aSelector) argumentNames collect: [ :each | FAMIXParameter named: each ]
]

{ #category : #'generator - method' }
DCCodeToUmlGenerator >> methodTypeFor: aSelector in: aClass [
	"@todo: RoelTyper can't detect method types"

	^ FAMIXClass named: #Object
]

{ #category : #'generator - attribute' }
DCCodeToUmlGenerator >> multiplicityFor: aSymbol in: aClass [
	(aClass includesSelector: aSymbol)
		ifTrue: [ (aClass >> aSymbol) pragmas
				detect: [ :each | each keyword = #DCType:multiplicity: ]
				ifFound: [ :pragma | 
					^ OPFAMIXMultiplicity new
						lower: (self lowerBoundFor: pragma);
						upper: (self upperBoundFor: pragma);
						yourself ] ].
	^ OPFAMIXMultiplicity one
]

{ #category : #'as yet unclassified' }
DCCodeToUmlGenerator >> processAssociationsIn: aClass [
	(aClass smalltalkClass methods flatCollect: #pragmas)
		select: [ :each | each keyword = #DCAssociation: ]
		thenDo: [ :pragma | 
			| assoc name |
			assoc := OPUmlDSLFactory new association: pragma arguments first , ';'.
			(aClass mooseModel allBinaryAssociations
				anySatisfy: [ :each | 
					each sourceEnd name = assoc sourceEnd name & (each targetEnd name = assoc targetEnd name)
						& (each source name = assoc source name) & (each target name = assoc target name) ])
				ifFalse: [ assoc
						source: (aClass mooseModel allModelClasses detect: [ :each | each name = assoc source name ]).
					assoc
						target: (aClass mooseModel allModelClasses detect: [ :each | each name = assoc target name ]).
					aClass mooseModel add: assoc ].
			name := pragma method selector.
			aClass attributes
				detect: [ :each | each name = name ]
				ifFound: [ :each | 
					each removeFromModel.
					aClass attributes remove: each ].
			(Array
				with: name
				with: name , ':'
				with: 'add' , name asEnglishSingular capitalized , ':'
				with: 'remove' , name asEnglishSingular capitalized , ':')
				do: [ :each | 
					aClass methods
						detect: [ :method | method name = each ]
						ifFound: [ :method | 
							method removeFromModel.
							aClass methods remove: method ] ] ]
]

{ #category : #postprocessing }
DCCodeToUmlGenerator >> processClassSide: aModel [
	aModel allClasses do: [ :each | self processClassSideFor: each ].
]

{ #category : #postprocessing }
DCCodeToUmlGenerator >> processClassSideFor: aClass [
	aClass attributes
		select: [ :each | each name beginsWith: SmalltalkImporter CIVString ]
		thenDo: [ :each | 
			each name: (each name withoutPrefix: SmalltalkImporter CIVString).
			each isStatic: true ].
	aClass methods do: [ :each | each isStatic: each hasClassScope ]
]

{ #category : #'as yet unclassified' }
DCCodeToUmlGenerator >> processDirectAttributesIn: aClass [
	aClass attributes
		do: [ :attr | 
			aClass methods
				detect: [ :method | method name = attr name ]
				ifFound: [ :getter | 
					getter compiledMethod pragmas
						detect: [ :each | each keyword = #DCType:multiplicity: ]
						ifFound: [ :pragma | 
							attr
								declaredType:
									(aClass mooseModel allModelClasses
										detect: [ :cls | cls name = pragma arguments first ]
										ifFound: [ :cls | cls ]
										ifNone: [ FAMIXClass named: pragma arguments first ]).
							attr
								multiplicity: (OPFAMIXMultiplicity fromArray: pragma arguments second).
							getter removeFromModel.
							aClass methods remove: getter.
							(Array
								with: attr name , ':'
								with: 'add' , attr name capitalized , ':'
								with: 'remove' , attr name capitalized , ':')
								do: [ :extraMethod | 
									aClass methods
										detect: [ :method | method name = extraMethod ]
										ifFound: [ :method | 
											method removeFromModel.
											aClass methods remove: method ] ] ] ] ]
]

{ #category : #'as yet unclassified' }
DCCodeToUmlGenerator >> processMethodsIn: aClass [
	aClass methods
		select: [ :each | each name = 'initialize' ]
		thenDo: [ :each | 
			each removeFromModel.
			aClass methods remove: each ].
	aClass methods
		do: [ :each | 
			each compiledMethod pragmas
				detect: [ :pragma | pragma keyword = 'DCMethod:' ]
				ifFound: [ :pragma | 
					| parsed |
					parsed := OPUmlDSLFactory new method: pragma arguments first.
					each parameters: parsed parameters asArray.
					"each declaredType: parsed declaredType."
					"each multiplicity: parsed multiplicity" ] ]
]

{ #category : #'as yet unclassified' }
DCCodeToUmlGenerator >> processPragmasFor: aModel [
	aModel allClasses do: [ :each | self processPragmasForClass: each ].
	self haltOnce
]

{ #category : #'as yet unclassified' }
DCCodeToUmlGenerator >> processPragmasForClass: aClass [
	self processDirectAttributesIn: aClass.
	self processAssociationsIn: aClass.
	self processMethodsIn: aClass.
	self haltOnce
]

{ #category : #'generator - attribute' }
DCCodeToUmlGenerator >> upperBoundFor: aPragma [
	aPragma arguments second
		ifNotEmpty: [ :range | 
			range size = 1
				ifTrue: [ range first = '*'
						ifTrue: [ ^ OPUnlimitedNatural max ]
						ifFalse: [ ^ range first ] ]
				ifFalse: [ range second = '*'
						ifTrue: [ ^ OPUnlimitedNatural max ]
						ifFalse: [ ^ range second ] ] ].
	^ 1
]
