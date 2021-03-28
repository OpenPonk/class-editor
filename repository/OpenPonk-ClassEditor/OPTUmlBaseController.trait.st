Trait {
	#name : #OPTUmlBaseController,
	#category : #'OpenPonk-ClassEditor-Controllers'
}

{ #category : #forms }
OPTUmlBaseController >> buildNameEditorForm: aForm [
	(aForm addTextInput: 'Name')
		text: self model name;
		whenTextIsAccepted: [ :newValue | 
			self model name: newValue.
			self reactToAttributeWrite ]
]

{ #category : #forms }
OPTUmlBaseController >> descriptionAccessor: aSymbol [
	^ MAPluggableAccessor
		read: [ :me | me model perform: aSymbol ]
		write: [ :me :newValue | 
			me model perform: (aSymbol , ':') asSymbol with: newValue.
			self reactToAttributeWrite ]
]

{ #category : #forms }
OPTUmlBaseController >> descriptionComment [
	<magritteDescription>
	^ MAMemoDescription new
		required: false;
		accessor:
			(MAPluggableAccessor
				read: [ :me | 
					me model ownedComments
						ifEmpty: [ '' ]
						ifNotEmpty: [ :oc | oc first body asString ] ]
				write: [ :me :newValue | 
					newValue asString
						ifEmpty: [ me model ownedComments: OrderedCollection new ]
						ifNotEmpty: [ me model ownedComments
								ifEmpty: [ me model ownedComments add: OPUMLComment new ].
							me model ownedComments first body: newValue asString ].
					self reactToAttributeWrite ]);
		label: 'Comment';
		priority: 100;
		yourself
]

{ #category : #forms }
OPTUmlBaseController >> descriptionModelInfo [
	<magritteDescription>
	^ MAStringDescription new
		beReadonly;
		accessor: (MAPluggableAccessor read: [ :me | '' ] write: [ :me :newValue |  ]);
		label: self nameOfType;
		priority: 0;
		yourself
]

{ #category : #forms }
OPTUmlBaseController >> descriptionName [
	<magritteDescription>
	^ MAStringDescription new
		accessor: (self descriptionAccessor: #name);
		label: 'Name';
		priority: 1;
		yourself
]

{ #category : #forms }
OPTUmlBaseController >> descriptionVisibility [
	<magritteDescription>
	^ MASingleOptionDescription new
		optionsAndLabels:
			{nil -> ''.
			OPUMLVisibilityKind public -> 'public'.
			OPUMLVisibilityKind protected -> 'protected'.
			OPUMLVisibilityKind private -> 'private'.
			OPUMLVisibilityKind new package -> 'package'};
		reference: MAStringDescription new;
		accessor:
			(MAPluggableAccessor
				read: [ :me | me model visibility ]
				write: [ :me :newValue | 
					me model visibility: newValue.
					self refreshFigure ]);
		label: 'Visibility';
		priority: 8;
		beSorted;
		yourself
]

{ #category : #hooks }
OPTUmlBaseController >> reactToAttributeWrite [
	self subclassResponsibility
]
