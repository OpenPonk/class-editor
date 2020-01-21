"
I am a Wizard for generating Cormas VW code from MooseModel.
"
Class {
	#name : #CECMVWGeneratorWizard,
	#superclass : #WizardControl,
	#instVars : [
		'model'
	],
	#classVars : [
		'LastValues'
	],
	#category : 'UMLClassEditor-Cormas-Windows'
}

{ #category : #'instance creation' }
CECMVWGeneratorWizard class >> open [
	<script>
	^ self new open
]

{ #category : #'instance creation' }
CECMVWGeneratorWizard class >> openOn: aModel [
	<script>
	^ self new
		model: aModel;
		open
]

{ #category : #adding }
CECMVWGeneratorWizard >> addConfigPane [
	| pane |
	pane := WizardSinglePane new.
	pane name: 'Export model to a *.xml.st file'.
	pane
		addPart:
			(SaveChooseFilePart new
				validExtensions: #('xml.st' 'st');
				yourself)
		associatedTo: #targetFile.
	self addPane: pane
]

{ #category : #'initialize-release' }
CECMVWGeneratorWizard >> initialize [
	super initialize.
	self addConfigPane.
	self atEndDo: [ :dictionary | self runGeneratorWith: dictionary ]
]

{ #category : #accessing }
CECMVWGeneratorWizard >> model: aModel [
	model := aModel
]

{ #category : #actions }
CECMVWGeneratorWizard >> runGeneratorWith: aDictionary [
	(aDictionary at: #targetFile) asFileReference
		ensureDelete;
		writeStreamDo: [ :stream | 
			stream
				nextPutAll: (UCMVWXmlExporter new writeModel: (UCMVWPimToPsmTransformer new generateFor: model with: nil)) ]
]
