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
				with: [ spec repository: 'github://openponk/uml-metamodel:v2.1.x/repository' ].
			spec
				baseline: 'OPUMLXMI'
				with: [ spec repository: 'github://openponk/uml-xmi:v2.1.x/repository' ].
			spec
				baseline: 'UMLBootstrapGenerator'
				with: [ spec
						repository: 'github://openponk/uml-bootstrap-generator:v2.1.x/repository' ].
			spec
				baseline: 'OpenPonk'
				with: [ spec repository: 'github://openponk/openponk:v2.1.x/repository' ].
			spec
				baseline: 'UMLShapes'
				with: [ spec
						repository: 'github://openponk/uml-shapes:v2.1.x/repository';
						loads: #(plugin) ].
			spec
				baseline: 'UMLProfiles'
				with: [ spec repository: 'github://openponk/uml-profiles:v2.1.x/repository' ].
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
		repository: 'github://openponk/ontouml-profile:v2.1.x/repository';
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
		baseline: 'OntoUMLVerificationFramework';
		repository: 'github://openponk/ontouml-verifications:v2.1.x';
		load: 'plugin'
]
