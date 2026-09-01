"
I am the abstract base ViewModel for items contained within a classifier, such as properties (attributes) or operations. I handle specific naming conventions and placeholder text generation.
"
Class {
	#name : 'OPUmlClassifierItemViewModel',
	#superclass : 'OPUmlElementViewModel',
	#category : 'OpenPonk-ClassEditor-ViewModels',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'ViewModels'
}

{ #category : 'forms' }
OPUmlClassifierItemViewModel >> descriptionName [
	<magritteDescription>
	| description |
	description := super descriptionName.
	description accessor writeBlock: [ :me :newValue |
		| text |
		text := newValue trim ifEmpty: [ self placeholderName ].
		me model name: text.
		self modelChanged ].
	^ description
]

{ #category : 'accessing' }
OPUmlClassifierItemViewModel >> placeholderName [

	^ self subclassResponsibility
]
