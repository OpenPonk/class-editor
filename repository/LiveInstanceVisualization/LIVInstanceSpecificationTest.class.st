Class {
	#name : 'LIVInstanceSpecificationTest',
	#superclass : 'TestCase',
	#instVars : [
		'model',
		'spec'
	],
	#category : 'LiveInstanceVisualization-Tests',
	#package : 'LiveInstanceVisualization',
	#tag : 'Tests'
}

{ #category : 'running' }
LIVInstanceSpecificationTest >> setUp [
	super setUp.
	spec := LIVInstanceSpecification new
]

{ #category : 'tests - printing' }
LIVInstanceSpecificationTest >> testPrintOn [
	spec name: 'item'.
	spec classifier: LIVTestItem.
	self assert: spec printString equals: 'InstSpec(item : LIVTestItem)'
]
