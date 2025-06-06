"
Baseline for https://github.com/OpenPonk/class-editor
"
Class {
	#name : 'BaselineOfOpenPonkClassEditor',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfOpenPonkClassEditor',
	#package : 'BaselineOfOpenPonkClassEditor'
}

{ #category : 'plugins' }
BaselineOfOpenPonkClassEditor class >> loadPlugins [
	self new loadPlugins
]

{ #category : 'baselines' }
BaselineOfOpenPonkClassEditor >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec
			baseline: 'OpenPonkUMLXMI'
			with: [ spec repository: 'github://openponk/uml-xmi' ].
		spec
			baseline: 'OpenPonkUMLBootstrapGenerator'
			with: [
			spec repository: 'github://openponk/uml-bootstrap-generator' ].
		spec
			baseline: 'OpenPonk'
			with: [ spec repository: 'github://openponk/openponk' ].
		spec
			baseline: 'OpenPonkUMLProfiles'
			with: [ spec repository: 'github://openponk/uml-profiles' ].
		spec package: 'OpenPonk-ClassEditor' with: [
			spec requires: #( 'OpenPonkUMLXMI' 'OpenPonkUMLBootstrapGenerator'
				   'OpenPonkUMLProfiles' ) ].

		spec group: 'plugin' with: #( 'OpenPonk-ClassEditor' ).
		(Smalltalk globals includesKey:
			 #BaselineOfOpenPonkOntoUMLVerifications)
			ifTrue: [ spec group: 'complete-plugin' with: #( plugin ) ]
			ifFalse: [
				self plugins: spec.
				spec package: 'OpenPonk-ClassEditor-Plugins' with: [
					spec requires:
						#( 'OpenPonkOntoUMLVerifications' OpenPonkOntoUMLPatterns
						   OpenPonkGit OpenPonkOntoUMLTransformations ) ].
				spec
					group: 'complete-plugin'
					with: #( plugin 'OpenPonk-ClassEditor-Plugins' ) ].
		spec group: 'complete' with: #( OpenPonk 'complete-plugin' ).
		spec group: 'default' with: #( OpenPonk plugin ) ]
]

{ #category : 'baselines' }
BaselineOfOpenPonkClassEditor >> plugins: spec [

	spec baseline: 'OpenPonkOntoUMLVerifications' with: [
		spec
			repository: 'github://openponk/ontouml-verifications';
			loads: 'plugin' ].
	spec baseline: 'OpenPonkOntoUMLTransformations' with: [
		spec
			repository:
				'github://openponk/openponk-ontouml-to-uml-transformation';
			loads: 'plugin' ].
	spec
		baseline: 'OpenPonkGit'
		with: [ spec repository: 'github://openponk/openponk-git' ].
	spec baseline: 'OpenPonkOntoUMLPatterns' with: [
		spec
			repository: 'github://openponk/ontouml-patterns';
			loads: 'plugin' ]
]
