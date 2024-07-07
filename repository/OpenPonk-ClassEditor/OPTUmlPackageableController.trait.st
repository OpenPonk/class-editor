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

	self packages reverseDo: [ :any |
		self diagramController
			controllerForModel: any
			ifFound: [ :parentPackageController |
				parentPackageController isRendered ifTrue: [
					^ aBlock value: parentPackageController ] ] ]
]

{ #category : 'accessing' }
OPTUmlPackageableController >> findPackagesIn: packagesList [

	| packagedElements |
	packagedElements := packagesList last packagedElements.
	(packagedElements identityIncludes: self model) ifTrue: [
		^ packagesList ].
	packagedElements
		select: [ :each | each oclIsKindOf: #Package ]
		thenDo: [ :each |
			(self findPackagesIn: (packagesList copyWith: each)) ifNotEmpty: [
				:foundList | ^ foundList ] ].
	^ LinkedList empty
]

{ #category : 'accessing' }
OPTUmlPackageableController >> hiddenPackages [

	| hiddenPackages |
	hiddenPackages := LinkedList new.
	self packages reverseDo: [ :each |
		self diagramController
			controllerForModel: each
			ifFound: [ :ctrl | ctrl isRendered ifTrue: [ ^ hiddenPackages ] ].
		hiddenPackages addFirst: each ].
	^ hiddenPackages
]

{ #category : 'accessing' }
OPTUmlPackageableController >> packages [

	^ packages ifNil: [
		  packages := self findPackagesIn: { self diagramController model } ]
]

{ #category : 'removing' }
OPTUmlPackageableController >> parentContainerModel [

	^ self parentPackageDo: [ :parentPackage | parentPackage ]
]

{ #category : 'accessing' }
OPTUmlPackageableController >> parentPackageDo: aBlock [

	^ aBlock value: (self packages ifEmpty: [ ^ nil ]) last
]

{ #category : 'accessing' }
OPTUmlPackageableController >> parentPackageDo: aBlock ifNone: noneBlock [

	^ aBlock value: (self packages ifEmpty: [ ^ noneBlock value ]) last
]

{ #category : 'removing' }
OPTUmlPackageableController >> removeModel [

	self parentPackageDo: [ :parentPackage |
		parentPackage packagedElements remove: self model ].
	super removeModel
]
