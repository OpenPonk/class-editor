"
I am an abstract controller for relationship-type elements.
"
Class {
	#name : 'OPUmlRelationshipController',
	#superclass : 'OPDirectionalRelationshipController',
	#traits : 'OPTUmlStereotypedElementController + OPTUmlPackageableController',
	#classTraits : 'OPTUmlStereotypedElementController classTrait + OPTUmlPackageableController classTrait',
	#category : 'OpenPonk-ClassEditor-Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Controllers'
}

{ #category : 'testing' }
OPUmlRelationshipController >> isHideable [
	^ true
]

{ #category : 'accessing' }
OPUmlRelationshipController >> magritteDescription [
	| container |
	container := MAPragmaBuilder for: self.
	container addAll: self stereotypeMagritteDescription.
	^ container
]

{ #category : 'construction' }
OPUmlRelationshipController >> registerModelInContainer: aParentModel [

	(aParentModel ifNil: [
		 (diagramController ifNil: [ source ifNil: [ target ] ])
			 diagramController model ]) packagedElements add: self model
]
