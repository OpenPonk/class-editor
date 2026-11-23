"
Unit tests for base UML element view model behavior, including stereotype application and removal, display formatting, model types, and property validation recovery.
"
Class {
	#name : 'OPUmlElementViewModelTest',
	#superclass : 'TestCase',
	#category : 'OpenPonk-ClassEditor-Tests-ViewModels',
	#package : 'OpenPonk-ClassEditor-Tests',
	#tag : 'ViewModels'
}

{ #category : 'tests' }
OPUmlElementViewModelTest >> testApplyStereotypeToIsIdempotentForStereotypeModel [

	| umlClass stereotype classViewModel firstInstance rebuildCount |
	umlClass := OPUMLClass new name: 'Watch'.
	stereotype := ClClockProfileFactory profile ownedStereotype anyOne.
	classViewModel := OPUmlClassViewModel new model: umlClass.
	rebuildCount := 0.
	classViewModel announcer when: OPElementFormNeedsRebuild do: [ rebuildCount := rebuildCount + 1 ] for: self.

	classViewModel applyStereotype: stereotype to: umlClass.
	firstInstance := umlClass appliedStereotypes first.
	classViewModel applyStereotype: stereotype to: umlClass.

	self assert: umlClass appliedStereotypes size equals: 1.
	self assert: umlClass appliedStereotypes first identicalTo: firstInstance.
	self assert: rebuildCount equals: 1
]

{ #category : 'tests' }
OPUmlElementViewModelTest >> testApplyStereotypeToReplacesExistingAndAcceptsDirectInstance [

	| umlClass classViewModel directClock issueStereotype |
	umlClass := OPUMLClass new name: 'TrackedClass'.
	classViewModel := OPUmlClassViewModel new model: umlClass.
	directClock := ClClock new.

	classViewModel applyStereotype: directClock to: umlClass.
	self assert: umlClass appliedStereotypes first identicalTo: directClock.

	issueStereotype := IPIssuesProfileFactory profile ownedStereotype anyOne.
	classViewModel applyStereotype: issueStereotype to: umlClass.
	self assert: umlClass appliedStereotypes size equals: 1.
	self assert: umlClass appliedStereotypes first umlClassName equals: issueStereotype name
]

{ #category : 'tests' }
OPUmlElementViewModelTest >> testClassMetadataAndDefaultAllTypeElements [

	| elementViewModel |
	self assert: OPUmlElementViewModel commonModelClassPrefix equals: 'OPUML'.
	self assert: OPUmlElementViewModel modelClass equals: OPUMLElement.
	elementViewModel := OPUmlClassViewModel new model: (OPUMLClass new
			                     name: 'Plain';
			                     yourself).
	self assertEmpty: elementViewModel allTypeElements
]

{ #category : 'tests' }
OPUmlElementViewModelTest >> testDescriptionModelInfoAndVisibility [

	| umlClass classViewModel infoDescription visibilityDescription |
	umlClass := OPUMLClass new name: 'Person'.
	classViewModel := OPUmlClassViewModel new model: umlClass.

	infoDescription := classViewModel descriptionModelInfo.
	self assert: (infoDescription accessor read: classViewModel) equals: ''.
	infoDescription accessor write: 'ignored' to: classViewModel.
	self assert: infoDescription isReadOnly description: 'Model info description must be read-only'.

	visibilityDescription := classViewModel descriptionVisibility.
	visibilityDescription accessor write: OPUMLVisibilityKind public to: classViewModel.
	self assert: (visibilityDescription accessor read: classViewModel) equals: OPUMLVisibilityKind public.
	self assert: umlClass visibility equals: OPUMLVisibilityKind public
]

{ #category : 'tests' }
OPUmlElementViewModelTest >> testDescriptionStereotypeContentWithoutAndWithAppliedProfile [

	| testProject rootPackage umlClass testRegistry classViewModel description |
	testProject := OPProject new.
	rootPackage := OPUMLPackage new name: 'Root'.
	umlClass := OPUMLClass new name: 'Timer'.
	rootPackage packagedElements add: umlClass.
	testProject addModel: rootPackage.
	testRegistry := OPViewModelRegistry forProject: testProject.
	classViewModel := testRegistry viewModelFor: umlClass.

	self
		assert: classViewModel descriptionStereotypeContent isNil
		description: 'Without applied profiles, stereotype description must be nil'.

	rootPackage profileApplications add: (OPUMLProfileApplication new
			 appliedProfile: ClClockProfileFactory profile;
			 yourself).
	description := classViewModel descriptionStereotypeContent.
	self assert: (description accessor read: classViewModel) isNil description: 'No stereotype applied initially'.

	description accessor write: 'Clock' to: classViewModel.
	self assert: (description accessor read: classViewModel) equals: 'Clock'.
	self assert: umlClass appliedStereotypes size equals: 1.

	description accessor write: nil to: classViewModel.
	self assert: (description accessor read: classViewModel) isNil description: 'Writing nil must remove applied stereotypes'.
	self assertEmpty: umlClass appliedStereotypes
]

{ #category : 'tests' }
OPUmlElementViewModelTest >> testModelDisplayStringAndModelTypeWithAndWithoutStereotype [

	| umlClass classViewModel plainDisplay stereotypedDisplay modelType |
	umlClass := OPUMLClass new name: 'Alarm'.
	classViewModel := OPUmlClassViewModel new model: umlClass.

	plainDisplay := String streamContents: [ :stream | classViewModel modelDisplayStringOn: stream ].
	self assert: plainDisplay equals: 'Alarm (Class)'.

	umlClass applyStereotype: ClClock new.
	stereotypedDisplay := String streamContents: [ :stream | classViewModel modelDisplayStringOn: stream ].
	self assert: stereotypedDisplay equals: 'Alarm (Clock)'.

	modelType := classViewModel modelType.
	self assert: modelType name equals: 'Class'.
	self assertCollection: (modelType subtypes collect: #name) hasSameElements: #( '«Clock»' )
]

{ #category : 'tests' }
OPUmlElementViewModelTest >> testRemoveStereotypesInWhenEmptyAndPopulated [

	| umlClass classViewModel rebuildCount |
	umlClass := OPUMLClass new name: 'Clocked'.
	classViewModel := OPUmlClassViewModel new model: umlClass.
	rebuildCount := 0.
	classViewModel announcer when: OPElementFormNeedsRebuild do: [ rebuildCount := rebuildCount + 1 ] for: self.

	classViewModel removeStereotypesIn: umlClass.
	self assert: rebuildCount equals: 0.

	umlClass applyStereotype: ClClock new.
	classViewModel removeStereotypesIn: umlClass.
	self assertEmpty: umlClass appliedStereotypes.
	self assert: rebuildCount equals: 1
]

{ #category : 'tests' }
OPUmlElementViewModelTest >> testStereotypesInForUsesPassedModelArgument [

	| umlPackage umlClass packageViewModel matchingStereotypes |
	umlPackage := OPUMLPackage new name: 'Root'.
	umlClass := OPUMLClass new name: 'Watch'.
	packageViewModel := OPUmlPackageViewModel new model: umlPackage.

	matchingStereotypes := packageViewModel stereotypesIn: ClClockProfileFactory profile for: umlClass.

	self assert: matchingStereotypes size equals: 1.
	self assert: matchingStereotypes anyOne name equals: 'Clock'
]

{ #category : 'tests' }
OPUmlElementViewModelTest >> testValidatePropertyAllFailureBranchesAndRepairs [

	| classA classB association endA endB classViewModel twoOwnersProp orphanTypedProp orphanUntypedProp warnings |
	classA := OPUMLClass new name: 'ClassA'.
	classB := OPUMLClass new name: 'ClassB'.
	association := OPUMLAssociation new name: 'Assoc'.
	endA := OPUMLProperty new
		        name: 'endA';
		        association: association;
		        owningAssociation: association;
		        yourself.
	endB := OPUMLProperty new
		        name: 'endB';
		        association: association;
		        owningClass: classB;
		        type: classA;
		        yourself.
	association memberEnds
		add: endA;
		add: endB.
	classViewModel := OPUmlClassViewModel new model: classA.
	warnings := OrderedCollection new.

	classViewModel validateProperty: nil.

	[ classViewModel validateProperty: endA ]
		on: OPModelInvalid
		do: [ :warning |
				warnings add: warning messageText.
				warning resume ].
	self assert: endA type identicalTo: classB.

	twoOwnersProp := OPUMLProperty new
		                 name: 'dual';
		                 owningClass: classA;
		                 owningAssociation: association;
		                 yourself.
	[ classViewModel validateProperty: twoOwnersProp ]
		on: OPModelInvalid
		do: [ :warning |
				warnings add: warning messageText.
				warning resume ].
	self assert: twoOwnersProp owningAssociation isNil description: 'Two-owner repair must clear owningAssociation'.

	orphanTypedProp := OPUMLProperty new
		                   name: 'orphanTyped';
		                   type: classA;
		                   yourself.
	[ classViewModel validateProperty: orphanTypedProp ]
		on: OPModelInvalid
		do: [ :warning |
				warnings add: warning messageText.
				warning resume ].
	self assert: orphanTypedProp owningClass identicalTo: classA.

	orphanUntypedProp := OPUMLProperty new
		                     name: 'orphanUntyped';
		                     yourself.
	[ classViewModel validateProperty: orphanUntypedProp ]
		on: OPModelInvalid
		do: [ :warning |
				warnings add: warning messageText.
				warning resume ].
	self assert: orphanUntypedProp owningClass isNil description: 'Untyped orphan cannot infer owningClass'.
	self assert: warnings size equals: 4
]

{ #category : 'tests' }
OPUmlElementViewModelTest >> testValidatePropertyWithSingleEndAssociationAndInvalidTypeResumesSafely [

	| association property associationViewModel warningCount |
	association := OPUMLAssociation new name: 'BrokenAssoc'.
	property := OPUMLProperty new
		            name: 'brokenEnd';
		            association: association;
		            owningAssociation: association;
		            yourself.
	association memberEnds add: property.
	associationViewModel := OPUmlAssociationViewModel new model: association.
	warningCount := 0.

	[ associationViewModel validateProperty: property ]
		on: OPModelInvalid
		do: [ :warning |
				warningCount := warningCount + 1.
				warning resume ].

	self assert: warningCount equals: 1.
	self assert: property type isNil description: 'Property type remains nil when no opposite end exists'
]
