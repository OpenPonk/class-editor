"
I am the abstract base controller for directed UML relationships (like associations or generalizations). I integrate stereotyped properties and package visibility into the relationship logic.
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
