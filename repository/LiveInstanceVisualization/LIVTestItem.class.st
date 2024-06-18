Class {
	#name : 'LIVTestItem',
	#superclass : 'Object',
	#instVars : [
		'name',
		'container'
	],
	#category : 'LiveInstanceVisualization-Tests',
	#package : 'LiveInstanceVisualization',
	#tag : 'Tests'
}

{ #category : 'accessing' }
LIVTestItem >> container [
	^ container
]

{ #category : 'accessing' }
LIVTestItem >> container: aContainer [
	container := aContainer
]

{ #category : 'accessing' }
LIVTestItem >> containerDirect: aContainer [
	container := aContainer
]

{ #category : 'accessing' }
LIVTestItem >> initialize [
	super initialize
]

{ #category : 'accessing' }
LIVTestItem >> name [
	^ name
]

{ #category : 'accessing' }
LIVTestItem >> name: aString [
	name := aString
]
