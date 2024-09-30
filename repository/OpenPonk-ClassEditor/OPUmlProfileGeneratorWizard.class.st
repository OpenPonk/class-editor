Class {
	#name : 'OPUmlProfileGeneratorWizard',
	#superclass : 'SpPresenter',
	#instVars : [
		'profile'
	],
	#category : 'OpenPonk-ClassEditor-UI',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'UI'
}

{ #category : 'example' }
OPUmlProfileGeneratorWizard class >> example [
	self openOn: (OPUMLProfile new name: 'Pro')
]

{ #category : 'instance creation' }
OPUmlProfileGeneratorWizard class >> openOn: aProfile [
	self basicNew
		profile: aProfile;
		initialize;
		open
]

{ #category : 'adding' }
OPUmlProfileGeneratorWizard >> addGeneratePane [
	| pane prefixPart packagePart |
	pane := WizardSinglePane new.
	pane name: 'Generate code for profile ' , profile name.
	(prefixPart := TextFieldPart new)
		inGroupboxNamed: 'Class Prefix';
		defaultValue: profile name.
	(packagePart := TextFieldPart new)
		inGroupboxNamed: 'Target Package';
		defaultValue: profile name , '-Profile'.
	pane row: prefixPart associatedTo: #prefix.
	pane row: packagePart associatedTo: #package.
	pane
		condition: [ :dict | (dict at: #prefix) isNotEmpty & (dict at: #package) isNotEmpty ]
		named: 'Prefix and package must not be empty.'.
	self addPane: pane
]

{ #category : 'initialization' }
OPUmlProfileGeneratorWizard >> generate: aProfile with: aDictionary [
	| generator |
	generator := OPUMLProfileGenerator new.
	generator sourceModel: aProfile.
	generator classPrefix: (aDictionary at: #prefix).
	generator packageName: (aDictionary at: #package).
	(CBChangesBrowser changes: generator generateAll) open
]

{ #category : 'initialization' }
OPUmlProfileGeneratorWizard >> generateWith: aDictionary [
	self generate: self profile with: aDictionary
]

{ #category : 'initialization' }
OPUmlProfileGeneratorWizard >> initialize [
	super initialize.
	self addGeneratePane.
	self atEndDo: [ :values | self generateWith: values ]
]

{ #category : 'accessing' }
OPUmlProfileGeneratorWizard >> profile [
	^ profile
]

{ #category : 'accessing' }
OPUmlProfileGeneratorWizard >> profile: anObject [
	profile := anObject
]
