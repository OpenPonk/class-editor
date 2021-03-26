"
Baseline for https://github.com/OpenPonk/class-editor
"
Class {
	#name : #BaselineOfClassEditor,
	#superclass : #BaselineOf,
	#category : #BaselineOfClassEditor
}

{ #category : #plugins }
BaselineOfClassEditor class >> loadPlugins [
	self new loadPlugins
]

{ #category : #accessing }
BaselineOfClassEditor >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec
				baseline: 'Moose'
				with: [ spec
						repository: 'github://moosetechnology/Moose:3693b26/src';
						loads: #(Merlin) ].
			spec
				baseline: 'UMLMetamodel'
				with: [ spec repository: 'github://openponk/uml-metamodel/repository' ].
			spec
				baseline: 'OPUMLXMI'
				with: [ spec repository: 'github://openponk/uml-xmi/repository' ].
			spec
				baseline: 'UMLBootstrapGenerator'
				with: [ spec
						repository: 'github://openponk/uml-bootstrap-generator/repository' ].
			spec
				baseline: 'OpenPonk'
				with: [ spec repository: 'github://openponk/openponk/repository' ].
			spec
				baseline: 'UMLShapes'
				with: [ spec
						repository: 'github://openponk/uml-shapes/repository';
						loads: #(plugin) ].
			spec
				baseline: 'UMLProfiles'
				with: [ spec repository: 'github://openponk/uml-profiles/repository' ].
			spec
				package: 'OpenPonk-ClassEditor'
				with: [ spec
						requires:
							#(Moose 'UMLShapes' 'UMLMetamodel' 'OPUMLXMI' 'UMLBootstrapGenerator' 'UMLProfiles') ].
			spec
				package: 'OPClassEditor-Plugins'
				with: [ spec postLoadDoIt: #loadPlugins ].
			spec group: 'plugin' with: #('OpenPonk-ClassEditor').
			spec
				group: 'complete-plugin'
				with: #(plugin 'OPClassEditor-Plugins').
			spec group: 'complete' with: #(OpenPonk 'complete-plugin').
			spec group: 'default' with: #(OpenPonk plugin) ]
]

{ #category : #'as yet unclassified' }
BaselineOfClassEditor >> loadOntoUML [
	Metacello new
		baseline: 'OntoUMLProfile';
		repository: 'github://openponk/ontouml-profile/repository';
		load: 'plugin'
]

{ #category : #plugins }
BaselineOfClassEditor >> loadPlugins [

	"self loadOntoUML. ""not neccessary as verification framework loads OntoUML"""
	self loadVerificationFramework
]

{ #category : #'as yet unclassified' }
BaselineOfClassEditor >> loadVerificationFramework [
	Metacello new
		baseline: 'ModelQuery';
		repository: 'github://openponk/ontouml-modelquery';
		load: #(plugin)

]
