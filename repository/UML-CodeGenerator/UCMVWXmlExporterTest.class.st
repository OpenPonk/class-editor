Class {
	#name : #UCMVWXmlExporterTest,
	#superclass : #TestCase,
	#instVars : [
		'exporter'
	],
	#category : 'UML-CodeGenerator-Tests'
}

{ #category : #running }
UCMVWXmlExporterTest >> setUp [
	super setUp.
	exporter := UCMVWXmlExporter new
]

{ #category : #tests }
UCMVWXmlExporterTest >> testSuperClassFor [
	| cls |
	cls := FAMIXClass named: 'Hello'.
	self assert: (exporter superClassFor: cls) equals: 'Core.Object'
]

{ #category : #'as yet unclassified' }
UCMVWXmlExporterTest >> testSuperClassFor2 [
	| cls supCls |
	cls := FAMIXClass named: 'Hello'.
	supCls := FAMIXClass named: 'Super'.
	FAMIXInheritance subclass: cls superclass: supCls.
	self assert: (exporter superClassFor: cls) equals: 'CormasNS.Models.UnknownModel.Super'
]

{ #category : #'as yet unclassified' }
UCMVWXmlExporterTest >> testSuperClassFor3 [
	| cls |
	cls := FAMIXClass named: 'Hello'.
	cls addStereotype: (OPFAMIXStereotype named: 'Entity').
	self assert: (exporter superClassFor: cls) equals: 'CormasNS.Kernel.Entity'
]
