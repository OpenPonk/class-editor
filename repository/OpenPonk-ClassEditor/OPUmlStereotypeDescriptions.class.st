"
Generates Magritte descriptions for attributes of stereotypes applied to a model element represented by a view model.
"
Class {
	#name : 'OPUmlStereotypeDescriptions',
	#superclass : 'Object',
	#instVars : [
		'viewModel'
	],
	#category : 'OpenPonk-ClassEditor-Profiles',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Profiles'
}

{ #category : 'instance creation' }
OPUmlStereotypeDescriptions class >> for: aViewModel [
	^ self new
		viewModel: aViewModel;
		yourself
]

{ #category : 'accessing' }
OPUmlStereotypeDescriptions >> accessorFor: anAttribute of: aStereotype [
	^ MAPluggableAccessor
		read: [ :aViewModel | aStereotype perform: anAttribute name asSymbol ]
		write: [ :aViewModel :newValue |
			aStereotype
				perform: (anAttribute name , ':') asSymbol
				with: newValue.
			aViewModel modelChanged ]
]

{ #category : 'private' }
OPUmlStereotypeDescriptions >> addTo: aCollection attribute: anAttribute of: aStereotype [

	| typeMapping typeName uiName descriptionType |
	anAttribute type ifNil: [ ^ self ].
	typeName := anAttribute type name.
	typeMapping := Dictionary newFrom: {
			               (#Boolean -> MABooleanDescription).
			               (#String -> MAStringDescription) }.
	descriptionType := typeMapping at: typeName ifAbsent: [ ^ self ].
	uiName := (anAttribute name splitCamelCase collect: [ :each | each capitalized ]) joinUsing: ' '.
	typeName = #Boolean ifTrue: [ uiName := 'Is ' , uiName ].
	aCollection add: (descriptionType new
			 accessor: (self accessorFor: anAttribute of: aStereotype);
			 label: uiName capitalized;
			 priority: 5;
			 yourself)
]

{ #category : 'accessing' }
OPUmlStereotypeDescriptions >> descriptions [
	| result |
	self model ifNil: [ ^ #() ].
	result := OrderedCollection new.
	self model appliedStereotypes do: [ :appliedStereotype |
		| metaClass |
		metaClass := appliedStereotype umlMetaClass.
		metaClass allAttributes do: [ :attribute |
			self addTo: result attribute: attribute of: appliedStereotype ] ].
	^ result
]

{ #category : 'accessing' }
OPUmlStereotypeDescriptions >> model [
	^ viewModel ifNotNil: [ :activeViewModel | activeViewModel model ]
]

{ #category : 'accessing' }
OPUmlStereotypeDescriptions >> viewModel [
	^ viewModel
]

{ #category : 'accessing' }
OPUmlStereotypeDescriptions >> viewModel: aViewModel [
	viewModel := aViewModel
]
