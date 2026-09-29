"
I am a UI integration test class verifying the OpenPonk UML editor workbench interactions, such as opening the editor and inserting classes via the palette.
"
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
	| classPaletteEntry clickPoint targetRoassalShape mouseLeftClickEvent |
	classPaletteEntry := paletteEntries detect: [ :eachEntry | eachEntry label = 'Class' ].
	classPaletteEntry performAction.
	clickPoint := 0 @ 0.

	targetRoassalShape := view canvas
		shapeWithAction: RSMouseLeftClick
		forPositionInPixels: clickPoint.
	mouseLeftClickEvent := RSMouseLeftClick new.
	mouseLeftClickEvent shape: targetRoassalShape.
	mouseLeftClickEvent position: clickPoint.
	mouseLeftClickEvent canvas: view canvas.
	mouseLeftClickEvent shape announce: mouseLeftClickEvent.

	self
		assert: (model packagedElements asArray collect: #name)
		equals: #( 'Class' )
]
