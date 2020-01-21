Class {
	#name : #UPGGeneratorTest,
	#superclass : #UPGBaseGeneratorTest,
	#category : 'UML-CodeGenerator-Tests'
}

{ #category : #'instance creation' }
UPGGeneratorTest >> oneToManyAssociation [
	| source target association |
	source := FAMIXClass named: 'University'.
	target := FAMIXClass named: 'Department'.
	association := OPFAMIXBinaryAssociation source: source target: target.
	association sourceEnd
		name: 'university';
		multiplicity: OPFAMIXMultiplicity one.
	association targetEnd
		name: 'departments';
		aggregation: OPUmlAggregationKind composite;
		multiplicity: OPFAMIXMultiplicity zeroToMany.
	^ association
]

{ #category : #running }
UPGGeneratorTest >> setUp [
	super setUp.
	(generator := UPGGenerator new) context
		withAccessors;
		package: self categoryName.
	cls := self newClassNamed: #SomethingGenerated
]

{ #category : #tests }
UPGGeneratorTest >> testClassName [
	self assert: (generator classNameFor: 'MyObject') equals: 'MyObject'.
	self assert: (generator classNameFor: 'Object') equals: 'Object'.
]

{ #category : #tests }
UPGGeneratorTest >> testClassNameAlwaysPrefixed [
	generator context prefix: 'XX'.
	generator context alwaysUsePrefix.
	self assert: (generator classNameFor: 'MyObject') equals: 'XXMyObject'.
	self assert: (generator classNameFor: 'Object') equals: 'XXObject'
]

{ #category : #tests }
UPGGeneratorTest >> testClassNamePrefixed [
	generator context prefix: 'XX'.
	self assert: (generator classNameFor: 'MyObject') equals: 'XXMyObject'.
	self assert: (generator classNameFor: 'Object') equals: 'Object'
]

{ #category : #tests }
UPGGeneratorTest >> testCreateAccessors [
	model := FAMIXAttribute named: 'string' type: (FAMIXClass named: 'String').
	generator createAttributeFor: model in: cls.
	self assert: cls selectors equals: #(#string: #string).
	self
		assert: (cls >> #string:) ast
		equals: (RBParser parseMethod: 'string: aString string := aString').
	self
		assert: (cls >> #string) ast
		equals: (RBParser parseMethod: 'string <DCType: #String multiplicity: #(1)> ^ string')
]

{ #category : #tests }
UPGGeneratorTest >> testCreateAccessorsNot [
	generator context withoutAccessors.
	model := FAMIXAttribute named: 'string' type: (FAMIXClass named: 'String').
	generator createAttributeFor: model in: cls.
	self assert: cls selectors equals: #()
]

{ #category : #tests }
UPGGeneratorTest >> testCreateAttribute [
	model := FAMIXAttribute named: 'string' type: (FAMIXClass named: 'String').
	generator createAttributeFor: model in: cls.
	self assert: cls instVarNames equals: #(#string).
	self assert: cls classVarNames equals: #()
]

{ #category : #tests }
UPGGeneratorTest >> testCreateCollectionAccessors [
	generator context useEagerInitialization.
	(model := FAMIXAttribute
		named: 'numbers'
		type: (FAMIXClass named: 'Float'))
		multiplicity:
			OPFAMIXMultiplicity zeroToMany.
	generator createAttributeFor: model in: cls.
	self
		assertCollection: cls selectors
		hasSameElements: #(numbers numbers: addNumber: removeNumber: initialize).
	self assert: cls selectors size equals: 5.
	self
		assert: (cls >> #numbers:) ast
		equals: (RBParser parseMethod: 'numbers: aCollection numbers := aCollection').
	self
		assert: (cls >> #numbers) ast
		equals:
			(RBParser
				parseMethod: 'numbers <DCType: #Float multiplicity: #(0 *)> ^ numbers').
	self
		assert: (cls >> #addNumber:) ast
		equals: (RBParser parseMethod: 'addNumber: aFloat numbers add: aFloat').
	self
		assert: (cls >> #removeNumber:) ast
		equals: (RBParser parseMethod: 'removeNumber: aFloat numbers remove: aFloat').
	self
		assert: (cls >> #initialize) ast
		equals:
			(RBParser
				parseMethod: 'initialize super initialize. numbers := OrderedCollection new')
]

{ #category : #tests }
UPGGeneratorTest >> testCreateCollectionAttribute [
	(model := FAMIXAttribute
		named: 'numbers'
		type: (FAMIXClass named: 'Float'))
		multiplicity:
			OPFAMIXMultiplicity zeroToMany.
	generator createAttributeFor: model in: cls.
	self assert: cls instVarNames equals: #(numbers).
	self assert: cls classVarNames equals: #()
]

{ #category : #tests }
UPGGeneratorTest >> testCreateEmptyClass [
	| name |
	name := #SomethingGenerated2.
	model := FAMIXClass named: name.
	self deny: (Smalltalk globals includesKey: name).
	cls := generator createClassFor: model.
	self assert: (Smalltalk globals includesKey: name).
	self assert: cls name equals: name.
	self assert: cls instVarNames equals: #().
	self assert: cls superclass equals: Object
]

{ #category : #tests }
UPGGeneratorTest >> testCreateMethod [
	model := factory method: 'method(anArg: String, aCollection: Number[2..5]): Integer'.
	self flag: 'parser needs support for colon in the selector name'.
	model name: 'method:in:'.
	self assert: cls selectors equals: #().
	generator createMethodFor: model in: cls.
	self assert: cls selectors equals: #('method:in:').
	self
		assert: (cls >> #method:in:) ast
		equals:
			(RBParser
				parseMethod:
					'method: anArg in: aCollection <DCMethod: ''method:in:(anArg : String, aCollection : Number[2..5]) : Integer''> "not yet implemented"')
]

{ #category : #tests }
UPGGeneratorTest >> testCreateSetOfClasses [
	| parentModel childModel classes |
	parentModel := FAMIXClass named: 'GeneratorParent'.
	childModel := FAMIXClass named: 'GeneratorChild'.
	FAMIXInheritance subclass: childModel superclass: parentModel.
	classes := generator createClassesFor: (Array with: childModel with: parentModel).
	self assert: classes size equals: 2.
	self assert: classes first name equals: parentModel name.
	self assert: classes second name equals: childModel name.
	self assert: classes second superclass equals: classes first
]

{ #category : #tests }
UPGGeneratorTest >> testCreateStaticAccessors [
	model := FAMIXAttribute named: 'something' type: (FAMIXClass named: 'String').
	model isStatic: true.
	generator createAttributeFor: model in: cls.
	self assert: cls selectors equals: #().
	self assertCollection: cls class selectors hasSameElements: #(#something: #something).
	self
		assert: (cls class >> #something:) ast
		equals: (RBParser parseMethod: 'something: aString something := aString').
	self
		assert: (cls class >> #something) ast
		equals: (RBParser parseMethod: 'something <DCType: #String multiplicity: #(1)> ^ something')
]

{ #category : #tests }
UPGGeneratorTest >> testCreateStaticAttribute [
	(model := FAMIXAttribute named: 'something' type: (FAMIXClass named: 'String'))
		isStatic: true.
	generator createAttributeFor: model in: cls.
	self assert: cls instVarNames equals: #().
	self assert: cls classVarNames equals: #().
	self assert: cls class instVarNames equals: #(#something)
]

{ #category : #tests }
UPGGeneratorTest >> testCreateSubclassClass [
	| parentModel childModel parentCls childCls |
	parentModel := FAMIXClass named: 'GeneratorParent'.
	childModel := FAMIXClass named: 'GeneratorChild'.
	FAMIXInheritance subclass: childModel superclass: parentModel.
	parentCls := generator createClassFor: parentModel.
	childCls := generator createClassFor: childModel.
	self assert: parentCls name equals: parentModel name.
	self assert: childCls name equals: childModel name.
	self assert: childCls superclass equals: parentCls.
	parentCls removeFromSystem.
	childCls removeFromSystem
]

{ #category : #tests }
UPGGeneratorTest >> testDefaultValueExpression [
	(model := FAMIXAttribute named: 'numbers')
		multiplicity:
			OPFAMIXMultiplicity zeroToOne.
	self assert: (generator defaultValueExpressionFor: model) equals: nil
]

{ #category : #tests }
UPGGeneratorTest >> testDefaultValueExpression2 [
	(model := FAMIXAttribute named: 'numbers')
		multiplicity:
			OPFAMIXMultiplicity zeroToMany.
	self
		assert: (generator defaultValueExpressionFor: model)
		equals: 'OrderedCollection new'
]

{ #category : #tests }
UPGGeneratorTest >> testDefaultValueExpression3 [
	| expression |
	expression := '#(1 2 3)'.
	(model := FAMIXAttribute named: 'numbers')
		multiplicity: OPFAMIXMultiplicity oneToMany;
		defaultValue: (OPFAMIXValueSpecification from: expression).
	self assert: (generator defaultValueExpressionFor: model) equals: expression
]

{ #category : #tests }
UPGGeneratorTest >> testDontCreateForeignClass [
	model := FAMIXClass named: #UPGTestForeign.
	self assert: model smalltalkClass superclass equals: String.
	self deny: model smalltalkClass package name = generator context package.
	self assert: model smalltalkClass instVarNames asArray equals: #(someVar).
	self assert: (generator createClassFor: model) equals: model smalltalkClass.
	self assert: model smalltalkClass superclass equals: String.
	self deny: model smalltalkClass package name = generator context package.
	self assert: model smalltalkClass instVarNames asArray equals: #(someVar)
]

{ #category : #tests }
UPGGeneratorTest >> testEnsureInitialize [
	self deny: (cls includesSelector: #initialize).
	generator ensureHasInitialize: cls.
	self assert: (cls includesSelector: #initialize).
	generator ensureHasInitialize: cls.
	self assert: (cls includesSelector: #initialize)
]

{ #category : #tests }
UPGGeneratorTest >> testGetterPragma [
	model := FAMIXAttribute named: 'string' type: (FAMIXClass named: 'String').
	self
		assert: (generator getterPragmaFor: model)
		equals: (Pragma keyword: #DCType:multiplicity: arguments: #(#String #(1)))
]

{ #category : #tests }
UPGGeneratorTest >> testGetterPragma2 [
	(model := FAMIXAttribute named: 'string')
		multiplicity:
			OPFAMIXMultiplicity zeroToMany.
	self
		assert: (generator getterPragmaFor: model)
		equals: (Pragma keyword: #DCType:multiplicity: arguments: #(Object #(0 *)))
]

{ #category : #tests }
UPGGeneratorTest >> testInitialize [
	generator addToInitialize: '1 + 1' in: cls.
	self
		assert: (cls >> #initialize) ast
		equals: (RBParser parseMethod: 'initialize super initialize. 1 + 1')
]

{ #category : #tests }
UPGGeneratorTest >> testInitializeNoDuplicates [
	generator addToInitialize: '1 + 1' in: cls.
	generator addToInitialize: '1 + 1' in: cls.
	self
		assert: (cls >> #initialize) ast
		equals: (RBParser parseMethod: 'initialize super initialize. 1 + 1')
]

{ #category : #tests }
UPGGeneratorTest >> testIsForeignClass [
	self assert: (generator isForeignClass: (FAMIXClass named: #UPGTestForeign))
]

{ #category : #tests }
UPGGeneratorTest >> testIsForeignClassNot [
	self deny: (generator isForeignClass: (FAMIXClass named: 'Local'))
]

{ #category : #tests }
UPGGeneratorTest >> testMethodPragma [
	model := factory method: 'method(anArg: String, aCollection: Number[2..5]): Integer'.
	self
		assert: (generator methodPragmaFor: model)
		equals:
			(Pragma
				keyword: #DCMethod:
				arguments: #('method(anArg : String, aCollection : Number[2..5]) : Integer'))
]

{ #category : #tests }
UPGGeneratorTest >> testModel [
	model := '
University {  }
President {  }

' asClassDiagram.
	generator generateFromModel: model
]

{ #category : #tests }
UPGGeneratorTest >> testMultiplicity [
	self
		assert:
			(generator multiplicityFor:
				OPFAMIXMultiplicity zeroToOne)
		equals: #(0 1).
	self
		assert:
			(generator multiplicityFor:
				OPFAMIXMultiplicity one)
		equals: #(1).
	self
		assert:
			(generator multiplicityFor:
				OPFAMIXMultiplicity zeroToMany)
		equals: #(0 *).
	self
		assert:
			(generator multiplicityFor:
				OPFAMIXMultiplicity oneToMany)
		equals: #(1 *)
]

{ #category : #tests }
UPGGeneratorTest >> testOverrideMethod [
	model := FAMIXMethod named: 'something'.
	cls compile: 'something "some content"'.
	generator context overrideMethods.
	generator createMethodFor: model in: cls.
	self
		assert: (cls >> #something) ast
		equals: (RBParser parseMethod: 'something <DCMethod: ''something()''> "not yet implemented"')
]

{ #category : #tests }
UPGGeneratorTest >> testOverrideMethodNot [
	model := FAMIXMethod named: 'something'.
	cls compile: 'something "unchanged content"'.
	generator context doNotOverrideMethods.
	generator createMethodFor: model in: cls.
	self
		assert: (cls >> #something) ast
		equals: (RBParser parseMethod: 'something "unchanged content"')
]

{ #category : #tests }
UPGGeneratorTest >> testSortHierarchy [
	| parent child |
	model := '
Parent {  }
Third {  }
Child {  }
Child >> Parent;
' asClassDiagram.
	parent := model allModelClasses detect: [ :each | each name = 'Parent' ].
	child := model allModelClasses detect: [ :each | each name = 'Child' ].
	self
		assert: ((generator sortedHierarchyFor: model allModelClasses) asArray collect: #name)
		equals: #(Parent Third Child)
]

{ #category : #'instance creation' }
UPGGeneratorTest >> unidirectionalAssociation [
	| source target association |
	source := FAMIXClass named: 'SourceSomething'.
	target := FAMIXClass named: 'TargetSomething'.
	association := OPFAMIXBinaryAssociation source: source target: target.
	association name: 'elements>'.
	association sourceEnd
		name: 'owner';
		beNonNavigable;
		multiplicity: OPFAMIXMultiplicity one.
	association targetEnd
		name: 'elements';
		multiplicity: OPFAMIXMultiplicity zeroToMany.
	^ association
]
