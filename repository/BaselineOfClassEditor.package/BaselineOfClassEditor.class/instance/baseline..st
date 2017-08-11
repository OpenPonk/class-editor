accessing
baseline: spec
	<baseline>
	spec
		for: #common
		do: [ spec
				project: 'Merlin'
				with: [ spec
						className: #ConfigurationOfMerlin;
						versionString: #development;
						repository: 'http://www.smalltalkhub.com/mc/Moose/Merlin/main' ].
			spec
				baseline: 'UMLShapes'
				with: [ spec repository: 'github://openponk/uml-shapes/repository' ].
			spec
				baseline: 'UMLMetamodel'
				with: [ spec repository: 'github://openponk/uml-metamodel/repository' ].
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
				project: 'Magritte'
				with: [ spec
						className: #ConfigurationOfMagritte3;
						versionString: #stable;
						repository: 'http://smalltalkhub.com/mc/Magritte/Magritte3/main/' ].
			spec
				package: 'OpenPonk-ClassEditor'
				with: [ spec
						requires: #('UMLShapes' 'UMLMetamodel' 'OPUMLXMI' 'UMLBootstrapGenerator' 'Magritte' 'Merlin') ].
			spec group: 'plugin' with: #('OpenPonk-ClassEditor').
			spec group: 'default' with: #('plugin' 'OpenPonk') ]