Trait {
	#name : 'OPTUmlPackageableController',
	#instVars : [
		'packages'
	],
	#category : 'OpenPonk-ClassEditor-Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Controllers'
}

{ #category : 'accessing' }
OPTUmlPackageableController >> closestRenderedPackageControllerDo: aBlock [

	self packageHierarchy reverseDo: [ :any |
		self diagramController
			controllerForModel: any
			ifFound: [ :parentPackageController |
				parentPackageController isRendered ifTrue: [
					^ aBlock value: parentPackageController ] ] ]
]

{ #category : 'accessing' }
OPTUmlPackageableController >> findPackageHierarchyIn: packagesList [

	| packagedElements |
	packagedElements := packagesList last packagedElements.
	(packagedElements identityIncludes: self packagedModel) ifTrue: [
		^ packagesList ].
	packagedElements
		select: [ :each | each oclIsKindOf: #Package ]
		thenDo: [ :each |
			(self findPackageHierarchyIn: (packagesList copyWith: each))
				ifNotEmpty: [ :foundList | ^ foundList ] ].
	^ #(  )
]

{ #category : 'accessing' }
OPTUmlPackageableController >> hiddenPackages [

	| hiddenPackages |
	hiddenPackages := LinkedList new.
	self packageHierarchy reverseDo: [ :each |
		self diagramController
			controllerForModel: each
			ifFound: [ :ctrl | ctrl isRendered ifTrue: [ ^ hiddenPackages ] ].
		hiddenPackages addFirst: each ].
	^ hiddenPackages
]

{ #category : 'accessing' }
OPTUmlPackageableController >> packageHierarchy [

	^ packages ifNil: [
		  packages := self findPackageHierarchyIn: { self diagramController model } ]
]

{ #category : 'accessing' }
OPTUmlPackageableController >> packagedModel [

	^ self model
]

{ #category : 'removing' }
OPTUmlPackageableController >> parentContainerModel [

	^ self parentPackageDo: [ :parentPackage | parentPackage ]
]

{ #category : 'enumerating' }
OPTUmlPackageableController >> parentPackageDo: aBlock [

	^ aBlock value: (self packageHierarchy ifEmpty: [ ^ nil ]) last
]

{ #category : 'accessing' }
OPTUmlPackageableController >> parentPackageDo: aBlock ifNone: noneBlock [

	^ aBlock value: (self packageHierarchy ifEmpty: [ ^ noneBlock value ]) last
]

{ #category : 'removing' }
OPTUmlPackageableController >> removeModel [

	self parentPackageDo: [ :parentPackage |
		parentPackage packagedElements remove: self model ifAbsent: [  ] ].
	super removeModel
]
