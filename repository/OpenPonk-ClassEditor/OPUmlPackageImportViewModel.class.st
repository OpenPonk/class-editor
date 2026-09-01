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
OPUmlPackageImportViewModel >> dependingOnElements [

	^ super dependingOnElements , {
		  self model importedPackage.
		  self model importingNamespace }
]

{ #category : 'forms' }
OPUmlPackageImportViewModel >> descriptionGeneral [
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
OPUmlPackageImportViewModel >> descriptionName [
	^ nil
]

{ #category : 'forms' }
OPUmlPackageImportViewModel >> descriptionSpecific [
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
OPUmlPackageImportViewModel >> descriptionVisibility [
	^ nil
]

{ #category : 'accessing' }
OPUmlPackageImportViewModel >> icon [

	^ OPUmlIcons directedAssociationIcon
]

{ #category : 'printing' }
OPUmlPackageImportViewModel >> modelDisplayStringOn: aStream [
    aStream nextPutAll: (self model importedPackage ifNotNil: #name ifNil: ['?']).
    aStream nextPutAll: ' --> '.
    aStream nextPutAll: (self model importingNamespace ifNotNil: #name ifNil: ['?']).
    aStream space; nextPutAll: '(PackageImport)'
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
