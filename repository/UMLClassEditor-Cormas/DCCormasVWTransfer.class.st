"
I transfer cormas code between Pharo and VW via SIF.
"
Class {
	#name : #DCCormasVWTransfer,
	#superclass : #ComposableModel,
	#instVars : [
		'packageDropList',
		'importButton',
		'exportButton',
		'packageLabel'
	],
	#category : 'UMLClassEditor-Cormas-Windows'
}

{ #category : #specs }
DCCormasVWTransfer class >> defaultSpec [
	^ SpecColumnLayout composed
		newRow: [ :r | 
			r
				add: #packageLabel width: 140;
				add: #packageDropList ]
			height: 22;
		newRow: [ :r |  ];
		newRow: [ :r | 
			r
				add: #importButton;
				add: #exportButton ]
			height: 50;
		yourself
]

{ #category : #'accessing - spec' }
DCCormasVWTransfer >> exportButton [
	^ exportButton
]

{ #category : #'as yet unclassified' }
DCCormasVWTransfer >> exportCode [
	| file |
	file := UIManager default
		fileSave: 'Select .sif file to store the package to'
		extensions: #('sif').
	file ifNil: [ ^ self inform: 'Canceled' ].
	SmalltalkInterchangeFileManager newForFileOut
		addPackageNamed: packageDropList selectedItem;
		fileName: file;
		fileOut.
	self inform: 'Exported'
]

{ #category : #'accessing - spec' }
DCCormasVWTransfer >> importButton [
	^ importButton
]

{ #category : #'as yet unclassified' }
DCCormasVWTransfer >> importCode [
	| stream |
	stream := UIManager default
		fileOpen: 'Select .sif file to extract the package from'
		extensions: #('sif').
	stream ifNil: [ ^ self inform: 'Canceled' ].
	SmalltalkInterchangeFileManager newForFileIn
		fileName: stream name;
		fileIn.
	self inform: 'Imported'
]

{ #category : #initialization }
DCCormasVWTransfer >> initializePresenter [
	importButton action: [ self importCode ].
	exportButton action: [ self exportCode ]
]

{ #category : #initialization }
DCCormasVWTransfer >> initializeWidgets [
	(packageLabel := self newLabel) label: 'Package'.
	(packageDropList := self newDropList)
		items: (RPackage organizer packages collect: #name as: SortedCollection);
		displayBlock: [ :item | item asString ].
	(importButton := self newButton) label: 'import code from file'.
	(exportButton := self newButton) label: 'export code to file'
]

{ #category : #'accessing - spec' }
DCCormasVWTransfer >> packageDropList [
	^ packageDropList
]

{ #category : #'accessing - spec' }
DCCormasVWTransfer >> packageLabel [
	^ packageLabel
]

{ #category : #'accessing - spec' }
DCCormasVWTransfer >> selectFileButton [
	^ selectFileButton
]

{ #category : #'accessing - spec' }
DCCormasVWTransfer >> selectedFileLabel [
	^ selectedFileLabel
]
