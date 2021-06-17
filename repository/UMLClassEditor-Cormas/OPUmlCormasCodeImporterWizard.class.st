"
I am a wizard for importing/reengineering Smalltalk code to UML model.

self open
"
Class {
	#name : #OPUmlCormasCodeImporterWizard,
	#superclass : #WizardControl,
	#instVars : [
		'model'
	],
	#category : 'UMLClassEditor-Cormas-Windows'
}

{ #category : #'instance creation' }
OPUmlCormasCodeImporterWizard class >> open [
	<script>
	^ self new open
]

{ #category : #'instance creation' }
OPUmlCormasCodeImporterWizard class >> openOn: aModel [
	<script>
	^ self new
		model: aModel;
		open
]

{ #category : #adding }
OPUmlCormasCodeImporterWizard >> addPackagePane [
	"Here we initialize the first wizard panel, which is related to selecting the packages
	 that will be added to the model"

	| pane packageList packagePanel |
	pane := WizardSinglePane new.
	pane name: 'Select packages to import'.
	packageList := RPackage organizer packageNames asSortedCollection: [ :a :b | a < b ].
	packagePanel := MultiSelectionItemSelectorPart new
		initialList: packageList;
		yourself.
	pane addPart: packagePanel associatedTo: #packagesSelected.
	self addPane: pane
]

{ #category : #actions }
OPUmlCormasCodeImporterWizard >> importWith: aDictionary [
	| pkgs allClasses filtered newModel |
	pkgs := (aDictionary at: #packagesSelected) collect: #asPackage.
	allClasses := pkgs flatCollect: #regularClasses.
	filtered := allClasses reject: [ :each | each isKindOf: TestCase ].
	newModel := DCCormasVWImporter new importFromClasses: filtered.
	self replaceModel: model with: newModel.
	model announcer announce: (OPModelContentReplaced model: model)
]

{ #category : #'initialize-release' }
OPUmlCormasCodeImporterWizard >> initialize [
	super initialize.
	self addPackagePane.
	self atEndDo: [ :dictionary | self importWith: dictionary ]
]

{ #category : #accessing }
OPUmlCormasCodeImporterWizard >> model: aModel [
	model := aModel
]

{ #category : #actions }
OPUmlCormasCodeImporterWizard >> replaceModel: aModel with: aNewModel [
	aModel entityStorage removeAll.
	aModel addAll: aNewModel entityStorage.
	^ aModel
]
