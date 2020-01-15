accessing
baseline: spec
	<baseline>
	spec
		for: #common
		do: [ 
			spec 
				baseline: 'Moose' 
				with: [ spec repository: 'github://moosetechnology/Moose:24a33d7/src'; 
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
				with: [ spec repository: 'github://openponk/uml-bootstrap-generator/repository' ].
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
				with: [ spec repository: 'github://magritte-metamodel/magritte:v3.5.4/source'; 
		             loads: #(Core) ].
			spec
				package: 'OpenPonk-ClassEditor'
				with: [ spec
						requires: #('UMLShapes' 'UMLMetamodel' 'OPUMLXMI' 'UMLBootstrapGenerator' 'OntoUMLProfile' 'UMLProfiles' 'Magritte' 'Moose') ].
			spec group: 'plugin' with: #('OpenPonk-ClassEditor').
			spec group: 'default' with: #('plugin' 'OpenPonk') ]