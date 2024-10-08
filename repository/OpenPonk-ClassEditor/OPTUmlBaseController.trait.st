Trait {
	#name : 'OPTUmlBaseController',
	#category : 'OpenPonk-ClassEditor-Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Controllers'
}

{ #category : 'forms' }
OPTUmlBaseController >> descriptionAccessor: aSymbol [

	^ MAPluggableAccessor
		  read: [ :me | me model perform: aSymbol ]
		  write: [ :me :newValue |
			  me model perform: (aSymbol , ':') asSymbol with: newValue.
			  self diagramElement modelChanged ]
]

{ #category : 'forms' }
OPTUmlBaseController >> descriptionComment [

	<magritteDescription>
	^ MAMemoDescription new
		  required: false;
		  accessor: (MAPluggableAccessor
				   read: [ :me | 
					   me model ownedComments
						   ifEmpty: [ '' ]
						   ifNotEmpty: [ :oc | oc first body asString ] ]
				   write: [ :me :newValue | 
					   newValue asString
						   ifEmpty: [ me model ownedComments: OrderedCollection new ]
						   ifNotEmpty: [ 
							   me model ownedComments ifEmpty: [ 
									   me model ownedComments add: OPUMLComment new ].
							   me model ownedComments first body: newValue asString ].
					   self diagramElement modelChanged ]);
		  label: 'Comment';
		  priority: 100;
		  lineCount: 10;
		  yourself
]

{ #category : 'forms' }
OPTUmlBaseController >> descriptionModelInfo [
	<magritteDescription>
	^ MAStringDescription new
		beReadOnly;
		accessor: (MAPluggableAccessor read: [ :me | '' ] write: [ :me :newValue |  ]);
		label: self nameOfType;
		priority: 0;
		yourself
]

{ #category : 'forms' }
OPTUmlBaseController >> descriptionName [
	<magritteDescription>
	^ MAStringDescription new
		accessor: (self descriptionAccessor: #name);
		label: 'Name';
		priority: 1;
		yourself
]

{ #category : 'forms' }
OPTUmlBaseController >> descriptionVisibility [

	<magritteDescription>
	^ MASingleOptionDescription new
		  optionsAndLabels: { 
				  (nil -> '').
				  (OPUMLVisibilityKind public -> 'public').
				  (OPUMLVisibilityKind protected -> 'protected').
				  (OPUMLVisibilityKind private -> 'private').
				  (OPUMLVisibilityKind new package -> 'package') };
		  reference: MAStringDescription new;
		  accessor: (MAPluggableAccessor
				   read: [ :me | me model visibility ]
				   write: [ :me :newValue | 
					   me model visibility: newValue.
					   self diagramElement modelChanged ]);
		  label: 'Visibility';
		  priority: 8;
		  beSorted;
		  yourself
]
