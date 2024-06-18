Class {
	#name : 'OPUmlDslExporterTest',
	#superclass : 'TestCase',
	#instVars : [
		'exporter',
		'result',
		'dslFactory'
	],
	#category : 'OpenPonk-UML-DSL-Tests',
	#package : 'OpenPonk-UML-DSL',
	#tag : 'Tests'
}

{ #category : 'asserting' }
OPUmlDslExporterTest >> export: aModel [
	result := exporter export: aModel
]

{ #category : 'asserting' }
OPUmlDslExporterTest >> export: aModel equals: expected [
	self export: aModel.
	self assert: result equals: expected
]

{ #category : 'running' }
OPUmlDslExporterTest >> parseAssociation: aString [
	^ dslFactory association: aString
]

{ #category : 'running' }
OPUmlDslExporterTest >> parseAttribute: aString [
	^ dslFactory attribute: aString
]

{ #category : 'running' }
OPUmlDslExporterTest >> parseClass: aString [
	^ dslFactory class: aString
]

{ #category : 'running' }
OPUmlDslExporterTest >> parseInheritance: aString [
	^ dslFactory inheritance: aString
]

{ #category : 'running' }
OPUmlDslExporterTest >> parseMethod: aString [
	^ dslFactory method: aString
]

{ #category : 'running' }
OPUmlDslExporterTest >> parseModel: aString [
	^ OPUmlDslParser new parse: aString
]

{ #category : 'running' }
OPUmlDslExporterTest >> setUp [
	exporter := OPUmlDslExporter new.
	dslFactory := OPUmlDSLFactory new
]

{ #category : 'tests' }
OPUmlDslExporterTest >> testAssociation [
	self export: (self parseAssociation: 'Left --> Right;') equals: 'Left --> Right;'
]

{ #category : 'tests' }
OPUmlDslExporterTest >> testAssociation1 [
	self
		export:
			(self
				parseAssociation: 'University[1] university <*>-- departments Department[*] :  composition;')
		equals: 'University university <*>-- departments Department[*] : composition;'
]

{ #category : 'tests' }
OPUmlDslExporterTest >> testAttribute [
	self
		export: (self parseAttribute: '_collection : Float[0..*]')
		equals: '_collection : Float[*]'
]

{ #category : 'tests' }
OPUmlDslExporterTest >> testAttribute1 [
	self
		export: (self parseAttribute: '_collection : Float[1..1]')
		equals: '_collection : Float'
]

{ #category : 'tests' }
OPUmlDslExporterTest >> testAttribute2 [
	self export: (self parseAttribute: 'id : Object[1..1]') equals: 'id'
]

{ #category : 'tests' }
OPUmlDslExporterTest >> testAttributeWithDefaultValue [
	self
		export: (self parseAttribute: 'workDays : String[5] = #(Monday Tuesday Wednesday Thursday Friday)')
		equals: 'workDays : String[5] = #(Monday Tuesday Wednesday Thursday Friday)'
]

{ #category : 'tests' }
OPUmlDslExporterTest >> testClass [
	self export: (self parseClass: '/::Class { }') equals: '/::Class { }'
]

{ #category : 'tests' }
OPUmlDslExporterTest >> testClassWithStereotype [
	self
		export: (self parseClass: '/::Class << meta , class >> { }')
		equals: '/::Class <<meta,class>> { }'
]

{ #category : 'tests' }
OPUmlDslExporterTest >> testClassWithStuff [
	self
		export:
			(self
				parseClass:
					'Mixin {
id
name : String
middleNames : String[*]
_workDays : String[5] = #(Monday Tuesday Wednesday Thursday Friday)
function()
inject:into:(aValue, aCollection)
add:afterIndex:(anObject : Object, anIndex: Integer) : Object
reject:(rejectBlock : BlockClosure[1]) : Object[*]
}')
		equals:
			'Mixin {
	id
	name : String
	middleNames : String[*]
	_workDays : String[5] = #(Monday Tuesday Wednesday Thursday Friday)
	function()
	inject:into:(aValue, aCollection)
	add:afterIndex:(anObject, anIndex : Integer) : Object
	reject:(rejectBlock : BlockClosure) : Object[*]
}'
]

{ #category : 'tests' }
OPUmlDslExporterTest >> testInheritance [
	self export: (self parseInheritance: 'Child >> Parent;') equals: 'Child >> Parent;'
]

{ #category : 'tests' }
OPUmlDslExporterTest >> testMethod [
	self export: (self parseMethod: '/_function()') equals: '_/function()'
]

{ #category : 'tests' }
OPUmlDslExporterTest >> testMethod1 [
	self export: (self parseMethod: 'funct:ion:(a, b)') equals: 'funct:ion:(a, b)'
]

{ #category : 'tests' }
OPUmlDslExporterTest >> testMethod2 [
	self
		export: (self parseMethod: 'funct:ion:(a : Object, b : String[1..1]) : Result[0..*]')
		equals: 'funct:ion:(a, b : String) : Result[*]'
]

{ #category : 'tests' }
OPUmlDslExporterTest >> testMethod3 [
	self
		export: (self parseMethod: 'notNil() : Object')
		equals: 'notNil() : Object'
]

{ #category : 'tests' }
OPUmlDslExporterTest >> testModel [
	self
		export:
			(self
				parseModel:
					'Person {
    name : String
    contact: Contact[1..*]
}

Teacher {
    gradeTests:(test: Test[*]): Number[*]
}

Teacher extends Role;
Student >> Role;
President >> Role;

Person --> roles Role[*];

President president --- university University;
University[1] university <*>-- departments Department[*];
Department[*] memberOf <>-- teachers Teacher[*];')
		equals:
			'Person {
	name : String
	contact : Contact[1..*]
}

Teacher {
	gradeTests:(test : Test[*]) : Number[*]
}

Role { }

President { }

University { }

Department { }

Student { }

Teacher >> Role;
Student >> Role;
President >> Role;

Person --> roles Role[*];
President president --- university University;
University university <*>-- departments Department[*];
Department[*] memberOf <>-- teachers Teacher[*];'
]
