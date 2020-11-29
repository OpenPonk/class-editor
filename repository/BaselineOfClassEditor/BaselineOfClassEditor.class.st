"
Baseline for https://github.com/OpenPonk/class-editor
"
Class {
	#name : #BaselineOfClassEditor,
	#superclass : #BaselineOf,
	#category : #BaselineOfClassEditor
}

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
				with: [ spec repository: 'github://openponk/uml-metamodel:v1.x/repository' ].
			spec
				baseline: 'OPUMLXMI'
				with: [ spec repository: 'github://openponk/uml-xmi:v2.0.1/repository' ].
			spec
				baseline: 'UMLBootstrapGenerator'
				with: [ spec
						repository: 'github://openponk/uml-bootstrap-generator:v2.0.0/repository' ].
			spec
				baseline: 'OpenPonk'
				with: [ spec repository: 'github://openponk/openponk:v2.0.0/repository' ].
			spec
				baseline: 'UMLShapes'
				with: [ spec
						repository: 'github://openponk/uml-shapes:v2.0.0/repository';
						loads: #(plugin) ].
			spec
				baseline: 'UMLProfiles'
				with: [ spec repository: 'github://openponk/uml-profiles:v2.0.0/repository' ].
			spec
				baseline: 'OntoUMLProfile'
				with: [ spec repository: 'github://openponk/ontouml-profile:v2.0.1/repository' ].
			spec
				baseline: 'OntoUMLVerificationFramework'
				with: [ spec repository: 'github://openponk/ontouml-verifications' ].
			spec
				package: 'OpenPonk-ClassEditor'
				with: [ spec
						requires:
							#(Moose 'UMLShapes' 'UMLMetamodel' 'OPUMLXMI' 'UMLBootstrapGenerator' 'OntoUMLProfile' 'UMLProfiles') ].
			spec
				group: 'no-verifications'
				with: #(OpenPonk 'OpenPonk-ClassEditor').
			spec
				group: 'plugin'
				with: #('OpenPonk-ClassEditor' 'OntoUMLVerificationFramework').
			spec group: 'default' with: #(OpenPonk plugin) ]
]
