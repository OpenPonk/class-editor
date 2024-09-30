"
I provide a range of examples for Uml Class Diagrams:
	- direct class instantiation
	- parsing from DSL
	- importing from Smalltalk code

!! Examples
see class-side
"
Class {
	#name : 'OPUmlExamples',
	#superclass : 'Object',
	#category : 'OpenPonk-ClassEditor-Examples',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Examples'
}

{ #category : 'accessing' }
OPUmlExamples class >> emptyEnumeration [

	^ OPUMLEnumeration new name: 'VisibilityKind'
]

{ #category : 'accessing' }
OPUmlExamples class >> emptyModel [

	<script: 'self emptyModel inspect'>
	^ OPUMLPackage new name: 'Empty Model'
]

{ #category : 'examples' }
OPUmlExamples class >> emptyProfile [

	<script: 'self emptyProfile inspect'>
	^ OPUMLProfile new
		  name: 'Profile';
		  yourself
]

{ #category : 'accessing' }
OPUmlExamples class >> enumerationWithLiterals [

	| enumeration |
	enumeration := self emptyEnumeration.
	#( public private protected package ) do: [ :each |
		| literal |
		literal := OPUMLEnumerationLiteral new name: each.
		enumeration ownedLiterals add: literal ].
	^ enumeration
]

{ #category : 'accessing' }
OPUmlExamples class >> exampleGeneralizationSets [

	<script: 'self exampleGeneralizationSets inspect'>
	| model insuredItem house car insuredHouse nonInsuredHouse houseSet insuredSet |
	model := self emptyModel.
	model name: 'Generalization Sets'.
	insuredItem := OPUMLClass new name: 'InsuredItem'.
	house := OPUMLClass new name: 'House'.
	car := OPUMLClass new name: 'Car'.
	insuredHouse := OPUMLClass new name: 'InsuredHouse'.
	nonInsuredHouse := OPUMLClass new name: 'NonInsuredHouse'.
	houseSet := OPUMLGeneralizationSet new
		            name: 'house gs';
		            isDisjoint: true.
	insuredSet := OPUMLGeneralizationSet new
		              name: 'insured gs';
		              isDisjoint: true;
		              isCovering: true.
	houseSet generalizations
		add: (OPUMLGeneralization new
				 general: insuredItem;
				 specific: car);
		add: (OPUMLGeneralization new
				 general: insuredItem;
				 specific: insuredHouse).
	insuredSet generalizations
		add: (OPUMLGeneralization new
				 general: house;
				 specific: insuredHouse);
		add: (OPUMLGeneralization new
				 general: house;
				 specific: nonInsuredHouse).
	model packagedElements: {
			insuredItem.
			house.
			car.
			insuredHouse.
			nonInsuredHouse.
			houseSet.
			insuredSet } asOrderedCollection.
	^ model
]

{ #category : 'accessing' }
OPUmlExamples class >> exampleRichClass [

	<script: 'self exampleRichClass inspect'>
	| model  |
	model := self emptyModel.
	model name: 'Rich Class Model'.
	model packagedElements add: self richClass.
	^ model
]

{ #category : 'accessing' }
OPUmlExamples class >> exampleSimpleAssociation [

	<script: 'self exampleSimpleAssociation inspect'>
	| element ownedComment comment owningElement assoc model |
	model := self emptyModel.
	model name: 'Simple Association'.
	element := OPUMLClass new name: 'Element'.
	comment := OPUMLClass new name: 'Comment'.
	assoc := OPUMLAssociation new.
	(ownedComment := OPUMLProperty new)
		name: 'ownedComment';
		lowerValue: (OPUMLLiteralInteger new value: 0);
		upperValue: (OPUMLLiteralUnlimitedNatural new value: '*');
		aggregation: OPUMLAggregationKind composite;
		owningClass: element;
		type: comment.
	(owningElement := OPUMLProperty new)
		name: 'owningElement';
		owningAssociation: assoc;
		type: element.
	assoc
		name: 'comments';
		memberEnds: {
				ownedComment.
				owningElement } asOrderedCollection.
	model packagedElements: {
			element.
			comment.
			assoc } asOrderedCollection.
	^ model
]

{ #category : 'accessing' }
OPUmlExamples class >> exampleSimpleGeneralization [

	<script: 'self exampleSimpleGeneralization inspect'>
	| cls cls2 model |
	model := self emptyModel.
	model name: 'Simple Generalization'.
	cls := OPUMLClass new name: 'Item'.
	cls2 := OPUMLClass new name: 'Thing'.
	OPUMLGeneralization new
		general: cls2;
		specific: cls.
	model packagedElements: {
			cls.
			cls2 } asOrderedCollection.
	^ model
]

{ #category : 'menu' }
OPUmlExamples class >> menuCommandOn: aBuilder [

	<worldMenu>
	(aBuilder item: #UMLClassEditor)
		icon: OPCoreIcons openponkIcon;
		label: 'UML Class Diagram Editor';
		action: [ self openExampleEmptyModel ];
		parent: #MostUsedTools;
		order: 205;
		with: [ 
			(aBuilder item: #UMLEmptyPackage)
				parent: #UMLClassEditor;
				label: 'New Empty Package';
				icon: OPUmlIcons packageIcon;
				action: [ self openExampleEmptyModel ].
			(aBuilder item: #UMLEmptyProfile)
				parent: #UMLClassEditor;
				label: 'New Empty Profile';
				icon: OPUmlIcons profileIcon;
				action: [ self openExampleEmptyProfile ];
				withSeparatorAfter.
			(aBuilder item: #UMLCompleteClass)
				parent: #UMLClassEditor;
				label: 'Rich Class';
				icon: OPUmlIcons modelIcon;
				action: [ self openExampleRichClass ].
			(aBuilder item: #UMLExampleSimpleAssociation)
				parent: #UMLClassEditor;
				label: 'Simple Association';
				icon: OPUmlIcons modelIcon;
				action: [ self openExampleSimpleAssociation ].
			(aBuilder item: #UMLExampleGeneralizationSets)
				parent: #UMLClassEditor;
				label: 'Generalization Sets';
				icon: OPUmlIcons modelIcon;
				withSeparatorAfter;
				action: [ self openExampleGeneralizationSets ].
			(aBuilder item: #UMLMetamodelInspect)
				parent: #UMLClassEditor;
				label: 'Inspect UML Metamodel';
				icon: OPUmlIcons packageIcon;
				action: [ OPUMLXMISpecsStorage umlMetamodel inspect ] ]
]

{ #category : 'examples' }
OPUmlExamples class >> notUsedExampleCommonStructure [

	| uml cs |
	uml := OPUMLXMISpecsStorage umlMetamodel.
	cs := uml packagedElements detect: [ :each | 
		      each name = 'CommonStructure' ].
	^ (OPProject openOnModel: cs) showAllElementsInAllDiagrams
]

{ #category : 'examples' }
OPUmlExamples class >> openExample: aModel [

	| project |
	project := OPProject named: 'UML Example'.
	project addModel: aModel.
	^ (OPWorkbench openProject: project) showAllElementsInAllDiagrams
]

{ #category : 'examples' }
OPUmlExamples class >> openExampleEmptyModel [

	<example>
	^ self openExample: self emptyModel
]

{ #category : 'examples' }
OPUmlExamples class >> openExampleEmptyProfile [

	<example>
	^ self openExample: self emptyProfile
]

{ #category : 'examples' }
OPUmlExamples class >> openExampleGeneralizationSets [

	<example>
	^ self openExample: self exampleGeneralizationSets
]

{ #category : 'examples' }
OPUmlExamples class >> openExampleRichClass [

	<example>
	^ self openExample: self exampleRichClass
]

{ #category : 'examples' }
OPUmlExamples class >> openExampleSimpleAssociation [

	<example>
	^ self openExample: self exampleSimpleAssociation
]

{ #category : 'examples' }
OPUmlExamples class >> openExampleSimpleGeneralization [

	<example>
	^ self openExample: self exampleSimpleGeneralization
]

{ #category : 'accessing' }
OPUmlExamples class >> richClass [

	| class stateMachine comment enum |
	class := OPUMLClass new name: 'CompleteClass'.
	class isAbstract: true.
	#( 'Boolean' 'Integer' 'Real' 'String' 'UnlimitedNatural' ) do: [
		:each |
		| type |
		type := OPUMLXMISpecsStorage primitiveTypeNamed: each.
		class ownedAttributes add: (OPUMLProperty new
				 name: 'primitive' , each;
				 type: type) ].
	comment := OPUMLXMISpecsStorage metaClassNamed: 'Comment'.
	stateMachine := OPUMLXMISpecsStorage metaClassNamed: 'StateMachine'.
	class ownedAttributes add: (OPUMLProperty new
			 name: 'derived';
			 isDerived: true).
	class ownedAttributes add: (OPUMLProperty new
			 name: 'comments';
			 type: comment;
			 lowerValue: (OPUMLLiteralInteger new value: 0);
			 upperValue: (OPUMLLiteralUnlimitedNatural new value: '*')).
	class ownedAttributes add: (OPUMLProperty new
			 name: 'static';
			 type: stateMachine;
			 isStatic: true).
	class ownedOperations add: (OPUMLOperation new name: 'basicMethod').
	enum := (OPUMLXMISpecsStorage umlMetamodel packagedElements
		         flatCollect: #packagedElements) detect: [ :each |
		        each name = 'VisibilityKind' ].
	"	class ownedOperations
		add:
			((OPUMLOperation new name: 'staticMethod')
				in: [ :op | 
					op ownedParameters
						add:
							(OPUMLParameter new
								name: 'enum';
								type: enum) ];
				isStatic: true)."
	class ownedOperations add:
		((OPUMLOperation new name: 'abstractMethod')
			 in: [ :op |
				 op ownedParameters
					 add: (OPUMLParameter new
							  name: 'return';
							  type: (OPUMLXMISpecsStorage primitiveTypeNamed: 'String');
							  direction: OPUMLParameterDirectionKind return);
					 add: (OPUMLParameter new
							  name: 'arg1';
							  type: (OPUMLXMISpecsStorage primitiveTypeNamed: 'Integer'));
					 add: (OPUMLParameter new
							  name: 'arg2';
							  type: stateMachine;
							  lowerValue: (OPUMLLiteralInteger new value: 0);
							  upperValue: (OPUMLLiteralUnlimitedNatural new value: 1)) ];
			 isAbstract: true).
	^ class
]
