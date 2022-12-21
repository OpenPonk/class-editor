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

{ #category : #baselines }
BaselineOfClassEditor >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		spec baseline: 'Moose' with: [ 
			spec
				repository: 'github://moosetechnology/Moose:v9.0.1/src';
				loads: #( Merlin ) ].
		spec
			baseline: 'UMLMetamodel'
			with: [ 
			spec repository: 'github://openponk/uml-metamodel/repository' ].
		spec
			baseline: 'OPUMLXMI'
			with: [ spec repository: 'github://openponk/uml-xmi/repository' ].
		spec baseline: 'UMLBootstrapGenerator' with: [ 
			spec repository:
				'github://openponk/uml-bootstrap-generator/repository' ].
		spec
			baseline: 'OpenPonk'
			with: [ spec repository: 'github://openponk/openponk:dev-roassal3' ].
		spec baseline: 'UMLShapes' with: [ 
			spec
				repository: 'github://openponk/uml-shapes:dev-roassal3';
				loads: #( plugin ) ].
		spec
			baseline: 'UMLProfiles'
			with: [ 
			spec repository: 'github://openponk/uml-profiles/repository' ].
		spec package: 'OpenPonk-ClassEditor' with: [ 
			spec requires:
				#( Moose 'UMLShapes' 'UMLMetamodel' 'OPUMLXMI' 'UMLBootstrapGenerator'
				   'UMLProfiles' ) ].
		spec
			package: 'OPClassEditor-Plugins'
			with: [ spec postLoadDoIt: #loadPlugins ].
		spec group: 'plugin' with: #( 'OpenPonk-ClassEditor' ).
		spec
			group: 'complete-plugin'
			with: #( plugin 'OPClassEditor-Plugins' ).
		spec group: 'complete' with: #( OpenPonk 'complete-plugin' ).
		spec group: 'default' with: #( OpenPonk plugin ) ]
]

{ #category : #baselines }
BaselineOfClassEditor >> loadOntoUML [
	Metacello new
		baseline: 'OntoUMLProfile';
		repository: 'github://openponk/ontouml-profile';
		load: 'plugin'
]

{ #category : #baselines }
BaselineOfClassEditor >> loadOntoUMLToUMLTransformation [
	Metacello new
		baseline: 'OntoUMLTransformationFramework';
		repository: 'github://openponk/openponk-ontouml-to-uml-transformation';
		load: 'plugin'
]

{ #category : #baselines }
BaselineOfClassEditor >> loadOpenPonkGit [

	Metacello new
		baseline: 'OpenPonkGit';
		repository: 'github://openponk/openponk-git';
		load
]

{ #category : #baselines }
BaselineOfClassEditor >> loadPatterns [

	Metacello new
		baseline: 'OntoUMLPatterns';
		repository: 'github://openponk/ontouml-patterns';
		load: 'plugin'
]

{ #category : #plugins }
BaselineOfClassEditor >> loadPlugins [

	"self loadOntoUML. ""not neccessary as verification framework loads OntoUML"""

	self loadVerificationFramework.
	self loadOntoUMLToUMLTransformation.
	self loadOpenPonkGit.
	self loadPatterns
]

{ #category : #baselines }
BaselineOfClassEditor >> loadVerificationFramework [
	Metacello new
		baseline: 'OntoUMLVerificationFramework';
		repository: 'github://openponk/ontouml-verifications';
		load: 'plugin'
]
