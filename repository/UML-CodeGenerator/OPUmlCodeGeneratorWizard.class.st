"
I am a wizard for configuring code generator from UML to Smalltalk code.

see class-side
"
Class {
	#name : 'OPUmlCodeGeneratorWizard',
	#superclass : 'WizardControl',
	#instVars : [
		'model'
	],
	#classVars : [
		'LastValues'
	],
	#category : 'UML-CodeGenerator-Windows',
	#package : 'UML-CodeGenerator',
	#tag : 'Windows'
}

{ #category : 'instance creation' }
OPUmlCodeGeneratorWizard class >> open [
	<script>
	^ self new open
]

{ #category : 'instance creation' }
OPUmlCodeGeneratorWizard class >> openOn: aModel [
	<script>
	^ self new
		model: aModel;
		open
]

{ #category : 'adding' }
OPUmlCodeGeneratorWizard >> addAccessorsPartTo: aPane [
	| defaultValues types |
	defaultValues := self lastValues.
	aPane
		addPart:
			(CheckboxPart new
				label: 'Add accessors';
				defaultValue: (defaultValues at: #addAccessors))
		associatedTo: #addAccessors.
	types := {#simple -> 'Simple (no synchronization)'.
	#direct -> 'Direct synchronization (updating both sides)'.
	#fame -> 'Intermediate object (FAME) (todo)'}.
	aPane
		addPart:
			(DropListPart new
				inGroupboxNamed: 'Accessors style';
				horizontalSize: 300;
				list: types;
				format: [ :pair | pair value ];
				transformed: [ :pair | pair key ];
				defaultValue: (types detect: [ :each | each key = (defaultValues at: #accessorsStyle) ]))
		associatedTo: #accessorsStyle
]

{ #category : 'adding' }
OPUmlCodeGeneratorWizard >> addConfigPane [
	| pane defaultValues types |
	defaultValues := self lastValues.
	pane := WizardSinglePane new.
	pane name: 'Source Code Generator'.
	pane
		addPart:
			(TextFieldPart new
				inGroupboxNamed: 'Target package';
				defaultValue: (defaultValues at: #package))
		associatedTo: #package.
	pane
		addPart:
			(TextFieldPart new
				inGroupboxNamed: 'Prefix for class names (TODO)';
				defaultValue: (defaultValues at: #classPrefix))
		associatedTo: #classPrefix.
	"pane
		addPart:
			(CheckboxPart
				disable;
				label: 'Always use prefix*';
				defaultValue: (defaultValues at: #alwaysUsePrefix))
		associatedTo: #alwaysUsePrefix.
		
	pane
		addPart:
			(TextPart new
				text: '*If unchecked, existing classes not in the target package
will not be generated, so you can subclass system classes.')
		associatedTo: #textPart."
	self addAccessorsPartTo: pane.
	pane
		addPart:
			(CheckboxPart new
				label: 'Override existing methods';
				defaultValue: (defaultValues at: #overrideMethods))
		associatedTo: #overrideMethods.
	types := {#lazy -> 'Lazy (default values in getters)'.
	#eager -> 'Eager (default values in #initialize)'}.
	pane
		addPart:
			(DropListPart new
				inGroupboxNamed: 'Initialization type';
				horizontalSize: 300;
				list: types;
				format: [ :pair | pair value ];
				transformed: [ :pair | pair key ];
				defaultValue: (types detect: [ :each | each key = (defaultValues at: #initializationType) ]))
		associatedTo: #initializationType.
	self addPane: pane
]

{ #category : 'actions' }
OPUmlCodeGeneratorWizard >> createContextFrom: aDictionary [
	| context |
	context := UPGGeneratorContext new.
	context
		package: (aDictionary at: #package);
		prefix: (aDictionary at: #classPrefix).
	aDictionary
		at: #alwaysUsePrefix
		ifPresent: [ :bool | 
			bool
				ifTrue: [ context alwaysUsePrefix ] ].
	(aDictionary at: #addAccessors)
		ifTrue: [ context withAccessors ]
		ifFalse: [ context withoutAccessors ].
	context accessorsStyle: (aDictionary at: #accessorsStyle).
	(aDictionary at: #initializationType) = #lazy
		ifTrue: [ context useLazyInitialization ].
	(aDictionary at: #initializationType) = #eager
		ifTrue: [ context useEagerInitialization ].
	(aDictionary at: #overrideMethods)
		ifTrue: [ context overrideMethods ]
		ifFalse: [ context doNotOverrideMethods ].
	context withProgressBar.
	^ context
]

{ #category : 'initialize-release' }
OPUmlCodeGeneratorWizard >> initialize [
	super initialize.
	self addConfigPane.
	self
		atEndDo: [ :dictionary | 
			LastValues := dictionary.
			self runGeneratorWith: (self createContextFrom: dictionary) ]
]

{ #category : 'accessing' }
OPUmlCodeGeneratorWizard >> lastValues [
	^ LastValues
		ifNil: [ {#package -> 'Unclassified'.
			#classPrefix -> ''.
			#alwaysUsePrefix -> false.
			#addAccessors -> true.
			#accessorsStyle -> #simple.
			#overrideMethods -> true.
			#initializationType -> #lazy} asDictionary ]
]

{ #category : 'accessing' }
OPUmlCodeGeneratorWizard >> model: aModel [
	model := aModel
]

{ #category : 'actions' }
OPUmlCodeGeneratorWizard >> runGeneratorWith: aContext [
	UPGGenerator new
		context: aContext;
		generateFromModel: model
]
