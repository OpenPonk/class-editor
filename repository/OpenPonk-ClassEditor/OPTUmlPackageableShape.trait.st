Trait {
	#name : 'OPTUmlPackageableShape',
	#instVars : [
		'hiddenPackages'
	],
	#category : 'OpenPonk-ClassEditor-Shapes',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Shapes'
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
