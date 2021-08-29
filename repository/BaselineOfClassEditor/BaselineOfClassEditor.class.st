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
				repository: 'github://moosetechnology/Moose:b5163b2/src';
				loads: #( Merlin ) ].
		spec
			baseline: 'UMLMetamodel'
			with: [ 
			spec repository: 'github://openponk/uml-metamodel:v3.0.x/repository' ].
		spec
			baseline: 'OPUMLXMI'
			with: [ spec repository: 'github://openponk/uml-xmi:v3.0.x/repository' ].
		spec baseline: 'UMLBootstrapGenerator' with: [ 
			spec repository:
				'github://openponk/uml-bootstrap-generator:v3.0.x/repository' ].
		spec baseline: 'OpenPonk' with: [ 
			spec
				repository: 'github://openponk/openponk:v3.0.x/repository';
				postLoadDoIt: #loadPetitParser ].
		spec baseline: 'UMLShapes' with: [ 
			spec
				repository: 'github://openponk/uml-shapes:v3.0.x/repository';
				loads: #( plugin ) ].
		spec
			baseline: 'UMLProfiles'
			with: [ 
			spec repository: 'github://openponk/uml-profiles:v3.0.x/repository' ].
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
		repository: 'github://openponk/ontouml-profile:v3.0.x/repository';
		load: 'plugin'
]

{ #category : #accessing }
BaselineOfClassEditor >> loadPetitParser [
	"this is solved separatedly by direct loading code because PetitParser does not specify Roassal2 version, which causes conflicts and this is probably only way to use onConflict:"

	Metacello new
		baseline: 'PetitParser';
		repository: 'github://moosetechnology/PetitParser:v2.x.x/src';
		onConflict: [ :err | err useLoaded ];
		load
]

{ #category : #plugins }
BaselineOfClassEditor >> loadPlugins [

	"self loadOntoUML. ""not neccessary as verification framework loads OntoUML"""
	self loadVerificationFramework
]

{ #category : #baselines }
BaselineOfClassEditor >> loadVerificationFramework [
	Metacello new
		baseline: 'OntoUMLVerificationFramework';
		repository: 'github://openponk/ontouml-verifications:v3.0.x';
		load: 'plugin'
]
