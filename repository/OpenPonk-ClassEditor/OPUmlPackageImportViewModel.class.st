"
I am the ViewModel for UML PackageImports, representing a directed relationship where one namespace imports the contents of a target package.
"
Class {
	#name : 'OPUmlPackageImportViewModel',
	#superclass : 'OPUmlElementViewModel',
	#category : 'OpenPonk-ClassEditor-ViewModels',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'ViewModels'
}

{ #category : 'accessing' }
OPUmlPackageImportViewModel class >> modelClass [ ^ OPUMLPackageImport
]

{ #category : 'construction' }
OPUmlPackageImportViewModel >> attachModelFrom: sourceViewModel to: targetViewModel [

	self model importingNamespace: sourceViewModel model.
	self model importedPackage: targetViewModel model
]

{ #category : 'private' }
OPUmlPackageImportViewModel >> basicRemoveModel [

	self model importingNamespace ifNotNil: [ :ns |
		ns packageImports remove: self model ifAbsent: [ ] ]
]

{ #category : 'accessing' }
OPUmlPackageImportViewModel >> creationPriority [
	"Edges must be created and rendered after connected nodes."
	^ 20
]

{ #category : 'accessing' }
OPUmlPackageImportViewModel >> dependingOnElements [

	^ super dependingOnElements , {
		  self model importedPackage.
		  self model importingNamespace }
]

{ #category : 'forms' }
OPUmlPackageImportViewModel >> descriptionName [
	^ nil
]

{ #category : 'forms' }
OPUmlPackageImportViewModel >> descriptionVisibility [
	^ nil
]

{ #category : 'accessing' }
OPUmlPackageImportViewModel >> icon [

	^ OPUmlIcons directedAssociationIcon
]

{ #category : 'printing' }
OPUmlPackageImportViewModel >> modelDisplayStringOn: aStream [

	| importedName importingName |
	importedName := (self model importedPackage ifNotNil: [ :package | package name ]) ifNil: [ '?' ].
	importingName := (self model importingNamespace ifNotNil: [ :namespace | namespace name ]) ifNil: [ '?' ].
	aStream nextPutAll: importedName.
	aStream nextPutAll: ' --> '.
	aStream nextPutAll: importingName.
	aStream space.
	aStream nextPutAll: '(PackageImport)'
]

{ #category : 'accessing' }
OPUmlPackageImportViewModel >> modelSource [

	^ self model importingNamespace
]

{ #category : 'accessing' }
OPUmlPackageImportViewModel >> modelTarget [

	^ self model importedPackage
]

{ #category : 'construction' }
OPUmlPackageImportViewModel >> registerModelIn: aParentModel [
	"No need to add - UML metamodel assigns it automatically via importingNamespace"
]
