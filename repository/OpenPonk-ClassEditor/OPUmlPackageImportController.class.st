"
I am a controller for a PackageImport.
"
Class {
	#name : 'OPUmlPackageImportController',
	#superclass : 'OPUmlRelationshipController',
	#category : 'OpenPonk-ClassEditor-Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Controllers'
}

{ #category : 'forms' }
OPUmlPackageImportController >> descriptionGeneral [
	"<magritteDescription>
	^ MAStringDescription new
		beReadonly;
		accessor:
			(MAPluggableAccessor read: [ :me | me model general name ] write: [ :me :newValue |  ]);
		label: 'General';
		priority: 1;
		yourself"
]

{ #category : 'forms' }
OPUmlPackageImportController >> descriptionName [
	^ nil
]

{ #category : 'forms' }
OPUmlPackageImportController >> descriptionSpecific [
"	<magritteDescription>
	^ MAStringDescription new
		beReadonly;
		accessor:
			(MAPluggableAccessor read: [ :me | me model specific name ] write: [ :me :newValue |  ]);
		label: 'Specific';
		priority: 2;
		yourself"
]

{ #category : 'forms' }
OPUmlPackageImportController >> descriptionVisibility [
	^ nil
]

{ #category : 'figures' }
OPUmlPackageImportController >> diagramElementClass [

	^ OPUmlPackageImportShape
]

{ #category : 'accessing' }
OPUmlPackageImportController >> modelClass [
	^ OPUMLPackageImport
]

{ #category : 'forms' }
OPUmlPackageImportController >> modelSource [

	^ self model importingNamespace
]

{ #category : 'figures' }
OPUmlPackageImportController >> modelSource: aModel in: aParentModel [
	"answers whether model's source has been changed"

	self modelSource = aModel ifTrue: [ ^ false ].
	self model importingNamespace: aModel.
	^ true
]

{ #category : 'forms' }
OPUmlPackageImportController >> modelTarget [

	^ self model importedPackage
]

{ #category : 'figures' }
OPUmlPackageImportController >> modelTarget: aModel in: aParentModel [
	"answers whether model's target has been changed"

	self modelTarget = aModel ifTrue: [ ^ false ].
	self model importedPackage: aModel.
	^ true
]

{ #category : 'removing' }
OPUmlPackageImportController >> removeModel [

	self model importedPackage: nil.
	self model importingNamespace: nil.
	super removeModel
]
