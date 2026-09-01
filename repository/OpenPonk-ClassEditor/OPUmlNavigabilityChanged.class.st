"
I am an announcement fired when the navigability of a UML Property (typically an association end) is altered, signaling that the visual arrows on the edge must be updated.
"
Class {
	#name : 'OPUmlNavigabilityChanged',
	#superclass : 'Announcement',
	#instVars : [
		'property'
	],
	#category : 'OpenPonk-ClassEditor-Announcements',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Announcements'
}

{ #category : 'instance creation' }
OPUmlNavigabilityChanged class >> property: aProperty [
	^ self new property: aProperty; yourself
]

{ #category : 'accessing' }
OPUmlNavigabilityChanged >> property [
	^ property
]

{ #category : 'accessing' }
OPUmlNavigabilityChanged >> property: aProperty [
	property := aProperty
]
