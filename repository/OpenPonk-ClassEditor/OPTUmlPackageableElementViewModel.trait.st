"
I am a trait for ViewModels representing UML elements that can belong to a package. I handle the domain logic for removing a packaged model from its parent package hierarchy.
"
Trait {
	#name : 'OPTUmlPackageableElementViewModel',
	#category : 'OpenPonk-ClassEditor-ViewModels',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'ViewModels'
}

{ #category : 'private' }
OPTUmlPackageableElementViewModel >> basicRemoveModel [
	"Automatically remove from owning package using the packageViewModel cache"

	self basicRemovePackagedModel
]

{ #category : 'as yet unclassified' }
OPTUmlPackageableElementViewModel >> basicRemovePackagedModel [
	"Automatically remove from owning package using the packageViewModel cache"

	self parentPackageViewModel ifNotNil: [ :pkgVM |
			pkgVM model ifNotNil: [ :pkgModel |
				pkgModel packagedElements remove: self model ifAbsent: [ ] ] ]
]
