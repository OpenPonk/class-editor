"
I am a trait for Roassal shapes representing UML elements that can hide their containing package path (e.g., displaying `MyClass` instead of `MyPackage::MyClass`).
"
Trait {
	#name : 'OPTUmlPackageableShape',
	#instVars : [
		'hiddenPackages'
	],
	#category : 'OpenPonk-ClassEditor-DiagramElements',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'DiagramElements'
}

{ #category : 'accessing' }
OPTUmlPackageableShape >> hiddenPackages [

	^ hiddenPackages ifNil: [ LinkedList empty ]
]

{ #category : 'accessing' }
OPTUmlPackageableShape >> hiddenPackages: packagesCollection [

	hiddenPackages = packagesCollection ifTrue: [ ^ false ].
	hiddenPackages := packagesCollection.
	^ true
]
