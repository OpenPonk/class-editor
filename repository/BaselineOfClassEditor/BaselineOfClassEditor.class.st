"
Baseline for https://github.com/OpenPonk/class-editor
"
Class {
	#name : #BaselineOfClassEditor,
	#superclass : #BaselineOf,
	#category : #BaselineOfClassEditor
}

{ #category : #'as yet unclassified' }
BaselineOfClassEditor class >> deps [
	<script>
	|deps b|
deps := {
#Generator -> #'UML-Model'.
#Generator -> #'UMLDSL'.
#Generator -> #'Famix-Core'.

#'UML-Model' -> #'Fame-Core'.
#'UML-Model' -> #'Famix-Core'.
#'UML-Model' -> #'Magritte-Model'.
#'UML-Model' -> #'Moose-Core'.

#ClassEditor -> #'DynaCASE-Core'.
#ClassEditor -> #'UML-Model'.
#ClassEditor -> #UMLDI.
#ClassEditor -> #UMLDSL.
#ClassEditor -> #'Fame-Core'.
#ClassEditor -> #'Famix-Core'.
#ClassEditor -> #'Magritte-Model'.
#ClassEditor -> #'Moose-Core'.
#ClassEditor -> #Roassal2.

#UMLDI -> #'Fame-Core'.
#UMLDI -> #Roassal2.

#UMLDSL -> #PetitParser.
#UMLDSL -> #'UML-Model'.
#UMLDSL -> #'Moose-Core'.
#UMLDSL -> #'Famix-Core'.
}.

b := RTMondrian new.
b shape label.
b nodes: ((deps collect: #key),(deps collect: #value)) asSet.
b edges shape arrowedLine.
b edges useAssociations: deps.
b layout sugiyama
	verticalGap: 50;
	horizontalGap: 30.
b build.
b view @ RTZoomableView.
b open
]

{ #category : #'as yet unclassified' }
BaselineOfClassEditor class >> depsInternal [
	<script>
	|deps b|
deps := {
#Generator -> #'UML-Model'.
#Generator -> #'UML-DSL'.

#ClassEditor -> #'UML-Model'.
#ClassEditor -> #'UML-DI'.
#ClassEditor -> #'UML-DSL'.

#'UML-DSL' -> #'UML-Model'.
}.

b := RTMondrian new.
b shape label.
b nodes: ((deps collect: #key),(deps collect: #value)) asSet.
b edges shape arrowedLine.
b edges useAssociations: deps.
b layout sugiyama
	verticalGap: 50;
	horizontalGap: 30.
b build.
b view @ RTZoomableView.
b open
]

{ #category : #accessing }
BaselineOfClassEditor >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec
				baseline: 'Moose'
				with: [ spec
						repository: 'github://moosetechnology/Moose:24a33d7/src';
						loads: #(Merlin) ].
			spec
				baseline: 'UMLShapes'
				with: [ spec repository: 'github://openponk/uml-shapes/repository' ].
			spec
				baseline: 'UMLMetamodel'
				with: [ spec repository: 'github://openponk/uml-metamodel:v1.x/repository' ].
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
				baseline: 'UMLProfiles'
				with: [ spec repository: 'github://openponk/uml-profiles:v1.x/repository' ].
			spec
				baseline: 'OntoUMLProfile'
				with: [ spec repository: 'github://openponk/ontouml-profile/repository' ].
			spec
				baseline: 'Magritte'
				with: [ spec
						repository: 'github://magritte-metamodel/magritte:v3.6/source';
						loads: #(Core);
						postLoadDoIt: #removeGreaseWarnings ].
			spec
				package: 'OpenPonk-ClassEditor'
				with: [ spec
						requires:
							#('UMLShapes' 'UMLMetamodel' 'OPUMLXMI' 'UMLBootstrapGenerator' 'OntoUMLProfile' 'UMLProfiles' 'Magritte' 'Moose') ].
			spec
				baseline: 'OntoUMLVerifications'
				with: [ spec repository: 'github://belohma2/OpenPonk-Verifications' ].
			spec
				group: 'plugin'
				with: #('OpenPonk-ClassEditor' 'OntoUMLVerifications').
			spec group: 'default' with: #('plugin' 'OpenPonk') ]
]

{ #category : #scripts }
BaselineOfClassEditor >> removeGreaseWarnings [
	('Grease-Pharo40-Slime' asPackageIfAbsent: [ ^ self ])
		removeFromSystem
]
