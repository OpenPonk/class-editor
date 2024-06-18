"
I produce fragments of a DCFAMIX model.
"
Class {
	#name : 'OPUmlDSLFactory',
	#superclass : 'Object',
	#instVars : [
		'classBuilder',
		'methodBuilder',
		'attributeBuilder',
		'dslBuilder'
	],
	#category : 'OpenPonk-UML-DSL-Builders',
	#package : 'OpenPonk-UML-DSL',
	#tag : 'Builders'
}

{ #category : 'examples' }
OPUmlDSLFactory class >> sampleDsl [
	'::MooseModel::

DCProject
--
dcID : UUID
dcName : String
--
addDiagram(aDiagram : DCDiagram)
layoutFor(aDiagram : DCDiagram) : Dictionary

DCModelObject

DCNamedElement < DCModelObject

DCDiagram < DCModelObject

DCDiagram <-> DCNamedElement
r1=owner
m1=0..1
r2=elements
m2=0..*

DCProject -> DCDiagram
m1=0..1
r2=diagrams
m2=0..*

DCModelObject <-> DCModelObject
m1=0..*
r2=owner
m2=0..1'
]

{ #category : 'factory methods' }
OPUmlDSLFactory >> association: aString [
	^ dslBuilder association parse: aString
]

{ #category : 'factory methods' }
OPUmlDSLFactory >> attribute: aString [
	^ attributeBuilder parse: aString
]

{ #category : 'factory methods' }
OPUmlDSLFactory >> class: aString [
	^ classBuilder parse: aString
]

{ #category : 'factory methods' }
OPUmlDSLFactory >> inheritance: aString [
	^ dslBuilder inheritance parse: aString
]

{ #category : 'initialization' }
OPUmlDSLFactory >> initialize [
	super initialize.
	classBuilder := OPUmlClassBuilder new.
	methodBuilder := OPUmlMethodBuilder new.
	attributeBuilder := OPUmlAttributeBuilder new.
	dslBuilder := OPUmlDslBuilder new
]

{ #category : 'factory methods' }
OPUmlDSLFactory >> method: aString [
	^ methodBuilder parse: aString
]

{ #category : 'factory methods' }
OPUmlDSLFactory >> model: aString [
	^ MooseModel named: aString
]
