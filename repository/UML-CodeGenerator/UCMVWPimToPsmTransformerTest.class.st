Class {
	#name : 'UCMVWPimToPsmTransformerTest',
	#superclass : 'TestCase',
	#instVars : [
		'pim',
		'transformer',
		'psm',
		'input',
		'result'
	],
	#category : 'UML-CodeGenerator-Tests',
	#package : 'UML-CodeGenerator',
	#tag : 'Tests'
}

{ #category : 'running' }
UCMVWPimToPsmTransformerTest >> setUp [
	super setUp.
	transformer := UCMVWPimToPsmTransformer new
]

{ #category : 'tests' }
UCMVWPimToPsmTransformerTest >> testAccessorsCollectionFor [
	input := FAMIXAttribute named: 'items'.
	input multiplicity upper: 2.
	transformer context withAccessors.
	result := transformer accessorsFor: input.
	self assert: (result collect: #name) equals: #(items items: addItem: removeItem:)
]

{ #category : 'tests' }
UCMVWPimToPsmTransformerTest >> testAccessorsFor [
	input := FAMIXAttribute named: 'item'.
	transformer context withAccessors.
	result := transformer accessorsFor: input.
	self assert: (result collect: #name) equals: #(item item:)
]

{ #category : 'tests' }
UCMVWPimToPsmTransformerTest >> testAccessorsNotFor [
	input := FAMIXAttribute named: 'item'.
	transformer context withoutAccessors.
	result := transformer accessorsFor: input.
	self assert: result equals: #()
]

{ #category : 'tests - accessors' }
UCMVWPimToPsmTransformerTest >> testAdderFor [
	input := FAMIXAttribute named: 'items'.
	input multiplicity upper: 2.
	result := transformer adderFor: input.
	self assert: result name equals: 'addItem:'.
	self assert: result protocol equals: 'adding/removing'
]

{ #category : 'tests - accessors' }
UCMVWPimToPsmTransformerTest >> testAdderSourceFor [
	input := FAMIXAttribute named: 'items'.
	input multiplicity upper: 2.
	result := transformer adderSourceFor: input.
	self
		assert: result body
		equals:
			'addItem: anObject
	items add: anObject'
]

{ #category : 'tests' }
UCMVWPimToPsmTransformerTest >> testClassAbstractFor [
	input := FAMIXClass named: 'Item'.
	input isAbstract: true.
	result := transformer classFor: input.
	self deny: result isAbstract.
	self assert: result methods size equals: 1.
	self assert: result methods first name equals: 'isAbstract'
]

{ #category : 'tests' }
UCMVWPimToPsmTransformerTest >> testClassFor [
	input := FAMIXClass named: 'Item'.
	input addAttribute: (FAMIXAttribute named: 'item').
	input addMethod: (FAMIXMethod named: 'asItem').
	result := transformer classFor: input.
	self deny: result = input.
	self assert: result name equals: 'Item'.
	self assert: result attributes first name equals: 'item'.
	self deny: result attributes first = input attributes first.
	self assert: (result methods collect: #name) asArray equals: #(item item: item_type asItem).
	self deny: result methods last = input methods last
]

{ #category : 'tests' }
UCMVWPimToPsmTransformerTest >> testCopyClassesFromTo [
	input := MooseModel new.
	input add: (FAMIXClass named: 'Child').
	input add: (FAMIXClass named: 'Parent').
	input
		add: (FAMIXInheritance subclass: input allClasses first superclass: input allClasses second).
	result := MooseModel new.
	transformer copyClassesFrom: input to: result.
	self assert: result allClasses size equals: 2.
	self assert: result allClasses first name equals: input allClasses first name.
	self deny: result allClasses first = input allClasses first.
	self assert: result allInheritanceDefinitions size equals: 1.
	self
		deny: result allInheritanceDefinitions first = input allInheritanceDefinitions first
]

{ #category : 'tests - meta' }
UCMVWPimToPsmTransformerTest >> testDefaultMethodFor [
	(input := FAMIXAttribute named: 'item')
		defaultValue: (OPFAMIXValueSpecification from: '15').
	result := transformer defaultMethodFor: input.
	self assert: result name equals: 'item_default'.
	self assert: result protocol equals: '- default value'.
	self assert: result isStatic
]

{ #category : 'tests - meta' }
UCMVWPimToPsmTransformerTest >> testDefaultMethodSourceFor [
	(input := FAMIXAttribute named: 'item')
		defaultValue: (OPFAMIXValueSpecification from: '15').
	result := transformer defaultMethodSourceFor: input.
	self
		assert: result body
		equals:
			'item_default
	^ 15'
]

{ #category : 'tests' }
UCMVWPimToPsmTransformerTest >> testEntityFor [
	pim := FAMIXClass named: 'item'.
	psm := transformer entityFor: pim.
	self deny: pim = psm.
	self assert: psm class equals: pim class.
	self assert: psm name equals: pim name
]

{ #category : 'tests - accessors' }
UCMVWPimToPsmTransformerTest >> testGetterFor [
	input := FAMIXAttribute named: 'item'.
	result := transformer getterFor: input.
	self assert: result name equals: 'item'.
	self assert: result protocol equals: 'accessing'
]

{ #category : 'tests - accessors' }
UCMVWPimToPsmTransformerTest >> testGetterSourceFor [
	input := FAMIXAttribute named: 'item'.
	result := transformer getterSourceFor: input.
	self
		assert: result body
		equals:
			'item
	^ item'
]

{ #category : 'tests - meta' }
UCMVWPimToPsmTransformerTest >> testIsAbstractMethodFor [
	input := FAMIXClass named: 'Item'.
	result := transformer isAbstractMethodFor: input.
	self assert: result name equals: 'isAbstract'.
	self assert: result protocol equals: 'testing'.
	self assert: result isStatic
]

{ #category : 'tests - meta' }
UCMVWPimToPsmTransformerTest >> testIsAbstractMethodSourceFor [
	input := FAMIXClass named: 'Item'.
	result := transformer isAbstractMethodSourceFor: input.
	self
		assert: result body
		equals:
			'isAbstract
	^ self = Item'
]

{ #category : 'tests - accessors' }
UCMVWPimToPsmTransformerTest >> testLazyGetterSourceFor [
	(input := FAMIXAttribute named: 'item')
		defaultValue: (OPFAMIXValueSpecification from: '15').
	result := transformer getterSourceFor: input.
	self
		assert: result body
		equals:
			'item
	^ item ifNil: [ item := 15 ]'
]

{ #category : 'tests' }
UCMVWPimToPsmTransformerTest >> testMetaForAttributeFor [
	input := FAMIXAttribute named: 'item'.
	result := transformer metaForAttributeFor: input.
	self assert: (result collect: #name) equals: #(item_type)
]

{ #category : 'tests' }
UCMVWPimToPsmTransformerTest >> testMetaForAttributeFor2 [
	(input := FAMIXAttribute named: 'item')
		defaultValue: (OPFAMIXValueSpecification from: '15');
		unit: 'kg'.
	result := transformer metaForAttributeFor: input.
	self assert: (result collect: #name) equals: #(item_default item_type item_unit)
]

{ #category : 'tests' }
UCMVWPimToPsmTransformerTest >> testModelFor [
	pim := MooseModel named: 'hello'.
	psm := transformer modelFor: pim.
	self assert: psm class equals: pim class.
	self assert: psm name equals: 'hello (PSM)'
]

{ #category : 'tests - accessors' }
UCMVWPimToPsmTransformerTest >> testRemoverFor [
	input := FAMIXAttribute named: 'items'.
	input multiplicity upper: 2.
	result := transformer removerFor: input.
	self assert: result name equals: 'removeItem:'.
	self assert: result protocol equals: 'adding/removing'
]

{ #category : 'tests - accessors' }
UCMVWPimToPsmTransformerTest >> testRemoverSourceFor [
	input := FAMIXAttribute named: 'items'.
	input multiplicity upper: 2.
	result := transformer removerSourceFor: input.
	self
		assert: result body
		equals:
			'removeItem: anObject
	items remove: anObject'
]

{ #category : 'tests - accessors' }
UCMVWPimToPsmTransformerTest >> testSetterFor [
	input := FAMIXAttribute named: 'item'.
	result := transformer setterFor: input.
	self assert: result name equals: 'item:'.
	self assert: result protocol equals: 'accessing'
]

{ #category : 'tests - accessors' }
UCMVWPimToPsmTransformerTest >> testSetterMultipleSourceFor [
	input := FAMIXAttribute named: 'item'.
	input multiplicity upper: 2.
	result := transformer setterSourceFor: input.
	self
		assert: result body
		equals:
			'item: aCollection
	item = aCollection ifTrue: [ ^ self ]. "for optimization"
	item := aCollection.
	self changed'
]

{ #category : 'tests - accessors' }
UCMVWPimToPsmTransformerTest >> testSetterSourceFor [
	input := FAMIXAttribute named: 'item'.
	result := transformer setterSourceFor: input.
	self
		assert: result body
		equals:
			'item: anObject
	item = anObject ifTrue: [ ^ self ]. "for optimization"
	item := anObject.
	self changed'
]

{ #category : 'tests - meta' }
UCMVWPimToPsmTransformerTest >> testTypeMethodFor [
	input := FAMIXAttribute named: 'item'.
	result := transformer typeMethodFor: input.
	self assert: result name equals: 'item_type'.
	self assert: result protocol equals: '+ parameter unit'.
	self assert: result isStatic
]

{ #category : 'tests - meta' }
UCMVWPimToPsmTransformerTest >> testTypeMethodSourceFor [
	(input := FAMIXAttribute named: 'item') declaredType: (FAMIXClass named: 'Number').
	result := transformer typeMethodSourceFor: input.
	self
		assert: result body
		equals:
			'item_type
	^ Number'
]

{ #category : 'tests - meta' }
UCMVWPimToPsmTransformerTest >> testUnitMethodFor [
	input := FAMIXAttribute named: 'item'.
	result := transformer unitMethodFor: input.
	self assert: result name equals: 'item_unit'.
	self assert: result protocol equals: '+ parameter unit'.
	self assert: result isStatic
]

{ #category : 'tests - meta' }
UCMVWPimToPsmTransformerTest >> testUnitMethodSourceFor [
	(input := FAMIXAttribute named: 'item') unit: 'kg'.
	result := transformer unitMethodSourceFor: input.
	self
		assert: result body
		equals:
			'item_unit
	^ ''kg'''
]
