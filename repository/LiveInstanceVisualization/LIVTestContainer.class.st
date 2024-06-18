Class {
	#name : 'LIVTestContainer',
	#superclass : 'Object',
	#instVars : [
		'items',
		'capacity'
	],
	#category : 'LiveInstanceVisualization-Tests',
	#package : 'LiveInstanceVisualization',
	#tag : 'Tests'
}

{ #category : 'adding' }
LIVTestContainer >> addItem: anItem [
	items add: anItem
]

{ #category : 'accessing' }
LIVTestContainer >> capacity [
	^ capacity
]

{ #category : 'accessing' }
LIVTestContainer >> capacity: anObject [
	capacity := anObject
]

{ #category : 'initialization' }
LIVTestContainer >> initialize [
	super initialize.
	items := OrderedCollection new
]

{ #category : 'removing' }
LIVTestContainer >> removeItem: anItem [
	items remove: anItem
]
