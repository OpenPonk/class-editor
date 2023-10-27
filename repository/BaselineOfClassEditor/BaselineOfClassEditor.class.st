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
		spec
			baseline: 'UMLMetamodel'
			with: [ spec repository: 'github://openponk/uml-metamodel' ].
		spec
			baseline: 'OPUMLXMI'
			with: [ spec repository: 'github://openponk/uml-xmi' ].
		spec
			baseline: 'UMLBootstrapGenerator'
			with: [
			spec repository: 'github://openponk/uml-bootstrap-generator' ].
		spec
			baseline: 'OpenPonk'
			with: [ spec repository: 'github://openponk/openponk' ].
		spec
			baseline: 'UMLProfiles'
			with: [ spec repository: 'github://openponk/uml-profiles' ].
		spec package: 'OpenPonk-ClassEditor' with: [
			spec requires:
				#( 'UMLMetamodel' 'OPUMLXMI' 'UMLBootstrapGenerator'
				   'UMLProfiles' ) ].

		spec group: 'plugin' with: #( 'OpenPonk-ClassEditor' ).
		(Smalltalk globals includesKey:
			 #BaselineOfOntoUMLVerificationFramework)
			ifTrue: [ spec group: 'complete-plugin' with: #( plugin ) ]
			ifFalse: [
				self plugins: spec.
				spec package: 'OPClassEditor-Plugins' with: [
					spec requires:
						#( 'OntoUMLVerificationFramework' OntoUMLPatterns
						   OpenPonkGit OntoUMLTransformationFramework ) ].
				spec
					group: 'complete-plugin'
					with: #( plugin 'OPClassEditor-Plugins' ) ].
		spec group: 'complete' with: #( OpenPonk 'complete-plugin' ).
		spec group: 'default' with: #( OpenPonk plugin ) ]
]

{ #category : #baselines }
BaselineOfClassEditor >> plugins: spec [

	spec baseline: 'OntoUMLVerificationFramework' with: [
		spec
			repository: 'github://openponk/ontouml-verifications';
			loads: 'plugin' ].
	spec baseline: 'OntoUMLTransformationFramework' with: [
		spec
			repository:
				'github://openponk/openponk-ontouml-to-uml-transformation';
			loads: 'plugin' ].
	spec
		baseline: 'OpenPonkGit'
		with: [ spec repository: 'github://openponk/openponk-git' ].
	spec baseline: 'OntoUMLPatterns' with: [
		spec
			repository: 'github://openponk/ontouml-patterns';
			loads: 'plugin' ]
]
