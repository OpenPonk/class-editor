"
I am a trait for controllers representing UML elements that can be packaged (like classes, data types, or sub-packages). I manage logic related to hidden packages and resolving the closest rendered parent package controller.
"
Trait {
	#name : 'OPTUmlPackageableController',
	#traits : 'OPTUmlBaseController',
	#classTraits : 'OPTUmlBaseController classTrait',
	#category : 'OpenPonk-ClassEditor-Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Controllers'
}

{ #category : 'accessing' }
OPTUmlPackageableController >> closestRenderedParentPackageControllerDo: aBlock [

	| closestPackageViewModel controller |
	closestPackageViewModel := self viewModel parentPackageViewModel.
	controller := nil.
	[
		closestPackageViewModel isNil or: [
				self diagramController
					controllerForModel: closestPackageViewModel model
					ifFound: [ :parentPackageController |
						(controller := parentPackageController) isRendered ]
					ifNone: [ false ] ] ] whileFalse: [
			closestPackageViewModel := closestPackageViewModel
				                           parentPackageViewModel ].
	closestPackageViewModel ifNil: [ ^ self ].
	^ aBlock value: controller
]

{ #category : 'accessing' }
OPTUmlPackageableController >> hiddenPackages [

	| closestPackageViewModel hiddenPackages |
	closestPackageViewModel := self viewModel packageViewModel.
	hiddenPackages := OrderedCollection new.

	[
		closestPackageViewModel isNotNil and: [
				self diagramController
					controllerForModel: closestPackageViewModel model
					ifFound: [ :parentPackageController |
					parentPackageController isRendered not ]
					ifNone: [ true ] ] ] whileTrue: [
			hiddenPackages add: closestPackageViewModel model.
			closestPackageViewModel := closestPackageViewModel
				                           parentPackageViewModel ].

	^ hiddenPackages reversed
]
