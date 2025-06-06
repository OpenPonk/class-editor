Class {
	#name : 'OPUmlEditorWorkbenchTest',
	#superclass : 'TestCase',
	#instVars : [
		'model',
		'project',
		'workbench',
		'window',
		'editor',
		'view',
		'paletteEntries'
	],
	#category : 'OpenPonk-ClassEditor-Tests - UI',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Tests - UI'
}

{ #category : 'instance creation' }
OPUmlEditorWorkbenchTest >> createAndOpenEmptyEditor [

	model := OPUMLPackage new.
	model name: 'Click Package'.
	project := OPProject new.
	project name: 'Click Project'.
	project addModel: model.
	workbench := OPWorkbench new.
	window := workbench open.
	workbench openProject: project.
	editor := (workbench instVarNamed: #editors) values first at: #editor.
	view := editor canvasPresenter canvas.
	paletteEntries := editor palette entries
]

{ #category : 'running' }
OPUmlEditorWorkbenchTest >> setUp [
	super setUp.
	self createAndOpenEmptyEditor
]

{ #category : 'running' }
OPUmlEditorWorkbenchTest >> tearDown [

	window ifNotNil: [ window close ].
	super tearDown
]

{ #category : 'tests' }
OPUmlEditorWorkbenchTest >> testAddClassFromPalette [

	| position shape ev classEntry link method |
	classEntry := paletteEntries detect: [ :each | each label = 'Class' ].
	classEntry performAction.
	position := 0 @ 0.
	shape := view canvas
		         shapeWithAction: RSMouseLeftClick
		         forPositionInPixels: position.
	ev := RSMouseLeftClick new.
	ev shape: shape.
	ev position: position.
	ev canvas: view canvas.
	"Pseudo-mock OPRenameElementCommand>>execute, so there's no asking user questions for a name."
	link := MetaLink new
		        metaObject: [ :object | 
			        (object instVarNamed: #controller) model name: 'Hello' ];
		        selector: #value:;
		        arguments: #( object );
		        control: #instead.
	method := OPInitialSetElementCommand >> #execute.
	method ast link: link.
	[ ev shape announce: ev ] ensure: [ link uninstall ].
	self
		assert: (model packagedElements asArray collect: #name)
		equals: #( Hello )
]
