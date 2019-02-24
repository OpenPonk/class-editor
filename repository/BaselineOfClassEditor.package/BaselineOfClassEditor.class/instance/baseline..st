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
				with: [ spec repository: 'github://openponk/uml-shapes:v1.0.1/repository' ].
			spec
				baseline: 'UMLMetamodel'
				with: [ spec repository: 'github://openponk/uml-metamodel:v1.0.0/repository' ].
			spec
				baseline: 'OPUMLXMI'
				with: [ spec repository: 'github://openponk/uml-xmi:v1.0.1/repository' ].
			spec
				baseline: 'UMLBootstrapGenerator'
				with: [ spec repository: 'github://openponk/uml-bootstrap-generator:v1.0.1/repository' ].
			spec
				baseline: 'OpenPonk'
				with: [ spec repository: 'github://openponk/openponk:v1.x/repository' ].
		spec
				baseline: 'UMLProfiles'
				with: [ spec repository: 'github://openponk/uml-profiles:v1.0.1/repository' ].
		spec
				baseline: 'OntoUMLProfile'
				with: [ spec repository: 'github://openponk/ontouml-profile:v1.0.0/repository' ].
			spec
				project: 'Magritte'
				with: [ spec
						className: #ConfigurationOfMagritte3;
						versionString: #stable;
						repository: 'http://smalltalkhub.com/mc/Magritte/Magritte3/main/' ].
			spec
				package: 'OpenPonk-ClassEditor'
				with: [ spec
						requires: #('UMLShapes' 'UMLMetamodel' 'OPUMLXMI' 'UMLBootstrapGenerator' 'OntoUMLProfile' 'UMLProfiles' 'Magritte' 'Merlin') ].
			spec group: 'plugin' with: #('OpenPonk-ClassEditor').
			spec group: 'default' with: #('plugin' 'OpenPonk') ]
