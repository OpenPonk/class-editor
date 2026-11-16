"
I am a Spec wizard presenter guiding the user through the process of compiling and generating Pharo classes and extension methods from a designed UML Profile model.
"
Class {
	#name : 'OPUmlProfileGeneratorWizard',
	#superclass : 'SpPresenter',
	#instVars : [
		'profile',
		'prefixLabel',
		'prefixInput',
		'packageLabel',
		'packageInput',
		'generateButton'
	],
	#category : 'OpenPonk-ClassEditor-UI',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'UI'
}

{ #category : 'layout' }
OPUmlProfileGeneratorWizard class >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  spacing: 6;
		  add: (SpBoxLayout newLeftToRight
				   spacing: 6;
				   add: #prefixLabel width: 110;
				   add: #prefixInput;
				   yourself)
		  expand: false;
		  add: (SpBoxLayout newLeftToRight
				   spacing: 6;
				   add: #packageLabel width: 110;
				   add: #packageInput;
				   yourself)
		  expand: false;
		  add: (SpBoxLayout newLeftToRight
				   add: SpBoxLayout newTopToBottom;
				   add: #generateButton width: 120;
				   yourself)
		  height: self buttonHeight;
		  yourself
]

{ #category : 'example' }
OPUmlProfileGeneratorWizard class >> example [
	self openOn: (OPUMLProfile new name: 'Pro')
]

{ #category : 'instance creation' }
OPUmlProfileGeneratorWizard class >> openOn: aProfile [

	^ (self on: aProfile) open
]

{ #category : 'accessing' }
OPUmlProfileGeneratorWizard >> classPrefix [

	^ prefixInput text asString trimBoth
]

{ #category : 'initialization' }
OPUmlProfileGeneratorWizard >> connectPresenters [

	prefixInput whenTextChangedDo: [ :text | self updateGenerateButtonState ].
	packageInput whenTextChangedDo: [ :text | self updateGenerateButtonState ].
	generateButton action: [ self generate ]
]

{ #category : 'accessing' }
OPUmlProfileGeneratorWizard >> defaultClassPrefix [

	| currentPrefix |
	profile ifNil: [ ^ '' ].
	currentPrefix := profile implementationPrefix.
	(currentPrefix isNotNil and: [ currentPrefix ~= 'XYZ' and: [ currentPrefix isNotEmpty ] ]) ifTrue: [ ^ currentPrefix ].
	^ profile name ifNil: [ '' ]
]

{ #category : 'accessing' }
OPUmlProfileGeneratorWizard >> defaultPackageName [

	| currentPackage |
	profile ifNil: [ ^ '' ].
	currentPackage := profile implementationPackage.
	(currentPackage isNotNil and: [ currentPackage ~= 'Unclassified' and: [ currentPackage isNotEmpty ] ]) ifTrue: [
		^ currentPackage ].
	^ profile name ifNil: [ '' ] ifNotNil: [ :profileName | profileName ifEmpty: [ '' ] ifNotEmpty: [ profileName , '-Profile' ] ]
]

{ #category : 'actions' }
OPUmlProfileGeneratorWizard >> generate [

	| browserWindow |
	browserWindow := (CBChangesBrowser changes: self generateChanges) open.
	self withWindowDo: [ :window | window close ].
	^ browserWindow
]

{ #category : 'accessing' }
OPUmlProfileGeneratorWizard >> generateButton [

	^ generateButton
]

{ #category : 'actions' }
OPUmlProfileGeneratorWizard >> generateChanges [

	| generator targetPrefix targetPackage |
	targetPrefix := self classPrefix.
	targetPackage := self packageName.
	self assert: (targetPrefix isNotEmpty and: [ targetPackage isNotEmpty ]).
	profile
		implementationPrefix: targetPrefix;
		implementationPackage: targetPackage.
	generator := OPUMLProfileGenerator new.
	generator sourceModel: profile.
	generator classPrefix: targetPrefix.
	generator packageName: targetPackage.
	^ generator generateAll
]

{ #category : 'initialization' }
OPUmlProfileGeneratorWizard >> initializePresenters [

	super initializePresenters.
	prefixLabel := self newLabel
		               label: 'Class Prefix:';
		               yourself.
	prefixInput := self newTextInput
		               text: self defaultClassPrefix;
		               yourself.
	packageLabel := self newLabel
		                label: 'Target Package:';
		                yourself.
	packageInput := self newTextInput
		                text: self defaultPackageName;
		                yourself.
	generateButton := self newButton
		                  label: 'Generate';
		                  yourself.
	self updateGenerateButtonState
]

{ #category : 'initialization' }
OPUmlProfileGeneratorWizard >> initializeWindow: aWindow [

	super initializeWindow: aWindow.
	aWindow
		title: 'Generate code for profile ' , ((profile ifNotNil: [ :p | p name ]) ifNil: [ '' ]);
		initialExtent: 420 @ 140
]

{ #category : 'accessing' }
OPUmlProfileGeneratorWizard >> packageInput [

	^ packageInput
]

{ #category : 'accessing' }
OPUmlProfileGeneratorWizard >> packageName [

	^ packageInput text asString trimBoth
]

{ #category : 'accessing' }
OPUmlProfileGeneratorWizard >> prefixInput [

	^ prefixInput
]

{ #category : 'accessing' }
OPUmlProfileGeneratorWizard >> profile [
	^ profile
]

{ #category : 'accessing' }
OPUmlProfileGeneratorWizard >> profile: anObject [

	profile := anObject.
	prefixInput ifNotNil: [ prefixInput text: self defaultClassPrefix ].
	packageInput ifNotNil: [ packageInput text: self defaultPackageName ]
]

{ #category : 'accessing - model' }
OPUmlProfileGeneratorWizard >> setModelBeforeInitialization: aProfile [

	profile := aProfile
]

{ #category : 'initialization' }
OPUmlProfileGeneratorWizard >> updateGenerateButtonState [

	generateButton enabled: (self classPrefix isNotEmpty and: [ self packageName isNotEmpty ])
]
