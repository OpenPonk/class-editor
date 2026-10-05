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

{ #category : 'adding' }
OPUmlStereotypeDescriptions >> addTo: aCollection attribute: anAttribute of: aStereotype [
	anAttribute type name = #Boolean ifTrue: [
		aCollection add:
			(MABooleanDescription new
				accessor: (self accessorFor: anAttribute of: aStereotype);
				label: 'Is ' , anAttribute name capitalized;
				priority: 5;
				yourself) ].
	anAttribute type name = #String ifTrue: [
		aCollection add:
			(MAStringDescription new
				accessor: (self accessorFor: anAttribute of: aStereotype);
				label: anAttribute name capitalized;
				priority: 5;
				yourself) ]
]

{ #category : 'accessing' }
OPUmlStereotypeDescriptions >> controller [
	^ controller
]

{ #category : 'accessing' }
OPUmlStereotypeDescriptions >> controller: anObject [
	controller := anObject
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
