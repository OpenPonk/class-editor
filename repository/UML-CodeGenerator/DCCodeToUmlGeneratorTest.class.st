Class {
	#name : 'DCCodeToUmlGeneratorTest',
	#superclass : 'UPGBaseGeneratorTest',
	#category : 'UML-CodeGenerator-Tests',
	#package : 'UML-CodeGenerator',
	#tag : 'Tests'
}

{ #category : 'running' }
DCCodeToUmlGeneratorTest >> setUp [
	super setUp.
	cls := self newClassNamed: #SomethingEmpty.
	generator := DCCodeToUmlGenerator new
]

{ #category : 'tests' }
DCCodeToUmlGeneratorTest >> testAttribute [
	cls addInstVarNamed: #something.
	model := generator createAttributeNamed: #something in: cls.
	self assert: model class equals: FAMIXAttribute.
	self assert: model declaredType name equals: #Object
]

{ #category : 'tests' }
DCCodeToUmlGeneratorTest >> testAttributeMultiplicity [
	| multiplicity |
	cls addInstVarNamed: #something.
	cls compile: 'something <DCType: #MyType multiplicity: #(2 10)> ^ something'.
	multiplicity := generator multiplicityFor: #something in: cls.
	self assert: multiplicity lower equals: 2.
	self assert: multiplicity upper equals: 10
]

{ #category : 'tests' }
DCCodeToUmlGeneratorTest >> testAttributePragma [
	cls addInstVarNamed: #something.
	cls compile: 'something <DCType: #MyType multiplicity: #(2 10)> ^ something'.
	model := generator createAttributeNamed: #something in: cls.
	self assert: model declaredType name equals: #MyType.
	self assert: model multiplicity lower equals: 2.
	self assert: model multiplicity upper equals: 10
]

{ #category : 'tests' }
DCCodeToUmlGeneratorTest >> testAttributeType [
	cls addInstVarNamed: #something.
	model := generator attributeTypeFor: #something in: cls.
	self assert: model class equals: FAMIXClass.
	self assert: model name equals: #Object
]

{ #category : 'tests' }
DCCodeToUmlGeneratorTest >> testAttributeTypeDefault [
	cls addInstVarNamed: #something.
	self assert: (generator attributeTypeNameFor: #something in: cls) equals: #Object
]

{ #category : 'tests' }
DCCodeToUmlGeneratorTest >> testAttributeTypePragma [
	cls addInstVarNamed: #something.
	cls compile: 'something <DCType: #MyType multiplicity: #(2 10)> ^ something'.
	self assert: (generator attributeTypeNameFor: #something in: cls) equals: #MyType
]

{ #category : 'tests' }
DCCodeToUmlGeneratorTest >> testEmptyClass [
	cls := self newClassNamed: #SomethingEmpty.
	model := generator createClassFor: cls.
	self assert: model class equals: FAMIXClass.
	self assert: model name equals: #SomethingEmpty.
	self assert: model attributes isEmpty.
	self assert: model methods isEmpty.
	self assert: model associations isEmpty
]

{ #category : 'tests' }
DCCodeToUmlGeneratorTest >> testLowerBound [
	{(#(1 10) -> 1).
	(#(2) -> 2).
	(#(#*) -> 0).
	(#(1 #*) -> 1)}
		do:
			[ :pair | 
			self
				assert:
					(generator
						lowerBoundFor: (Pragma keyword: #DCType:multiplicity: arguments: (Array with: #X with: pair key)))
				equals: pair value ]
]

{ #category : 'tests' }
DCCodeToUmlGeneratorTest >> testMethod [
	cls compile: 'method ^ 1'.
	model := generator createMethodFor: #method in: cls.
	self assert: model class equals: FAMIXMethod.
	self assert: model name equals: #method
]

{ #category : 'tests' }
DCCodeToUmlGeneratorTest >> testMethodWithParams [
	cls compile: 'add: aNumber to: anotherNumber ^ aNumber + anotherNumber'.
	model := generator createMethodFor: #add:to: in: cls.
	self assert: model class equals: FAMIXMethod.
	self assert: model name equals: #add:to:.
	self assert: model parameters size equals: 2.
	self assert: model parameters first class equals: FAMIXParameter.
	self assert: model parameters first name equals: #aNumber.
	self assert: model parameters second class equals: FAMIXParameter.
	self assert: model parameters second name equals: #anotherNumber
]

{ #category : 'tests' }
DCCodeToUmlGeneratorTest >> testMethodWithPragma [
	cls
		compile:
			'add: aNumber to: anotherNumber
		<DCMethod: ''add:to:(aNumber : Float, anotherNumber : Integer) : Number''>
		^ aNumber + anotherNumber'.
	model := generator createMethodFor: #add:to: in: cls.
	self assert: model class equals: FAMIXMethod.
	self assert: model name equals: #add:to:.
	self assert: model declaredType name equals: #Number.
	self assert: model parameters size equals: 3.
	self assert: model parameters first class equals: FAMIXParameter.
	self assert: model parameters first name equals: #aNumber.
	self assert: model parameters first declaredType name equals: #Float.
	self assert: model parameters second class equals: FAMIXParameter.
	self assert: model parameters second name equals: #anotherNumber.
	self
		assert: model parameters second declaredType name
		equals: #Integer.
	self assert: model parameters third class equals: FAMIXParameter.
	self assert: model parameters third name equals: #return.
	self assert: model parameters third declaredType name equals: #Number.
	self
		assert: model parameters third direction
		equals:
			OPUmlParameterDirectionKind return
]

{ #category : 'tests' }
DCCodeToUmlGeneratorTest >> testUpperBound [
	{#(1 10) -> 10.
	#(2) -> 2.
	#(*) ->
		OPUnlimitedNatural max.
	#(0 *) ->
		OPUnlimitedNatural max}
		do: [ :pair | 
			self
				assert:
					(generator
						upperBoundFor:
							(Pragma
								keyword: #DCType:multiplicity:
								arguments: (Array with: #X with: pair key)))
				equals: pair value ]
]
