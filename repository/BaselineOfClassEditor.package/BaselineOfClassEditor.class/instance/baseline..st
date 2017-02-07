accessing
baseline: spec
	<baseline>
	spec
		for: #common
		do: [ spec
				project: 'XMLParser'
				with: [ spec
						className: #ConfigurationOfXMLParser;
						versionString: #stable;
						repository: 'http://smalltalkhub.com/mc/PharoExtras/XMLParser/main/' ].
			spec
				baseline: 'XMLDOMVisitor'
				with: [ spec repository: 'github://peteruhnak/xml-dom-visitor/repository' ].
			spec
				project: 'XPath'
				with: [ spec
						className: #ConfigurationOfXPath;
						versionString: #stable;
						repository: 'http://smalltalkhub.com/mc/PharoExtras/XPath/main/' ].
			spec
				project: 'Merlin'
				with: [ spec
						className: #ConfigurationOfMerlin;
						versionString: #development;
						repository: 'http://www.smalltalkhub.com/mc/Moose/Merlin/main' ].
			spec
				baseline: 'OpenPonk'
				with: [ spec repository: 'github://openponk/openponk/repository' ].
			spec
				project: 'PetitParser'
					with: [ spec
						className: #ConfigurationOfPetitParser;
						versionString: #development;
						loads: #('Parser');
						repository: 'http://smalltalkhub.com/mc/Moose/PetitParser/main/' ];
				project: 'Fame'
					with: [ spec
						className: #ConfigurationOfFame;
						versionString: #development;
						repository: 'http://www.smalltalkhub.com/mc/Moose/Fame/main' ];
				package: 'CollectionExtensions'
					with: [ spec repository: 'http://www.smalltalkhub.com/mc/Moose/CollectionExtensions/main' ];
				package: 'Moose-Core'
					with: [ spec
						repository: 'http://www.smalltalkhub.com/mc/Moose/Moose/main';
						requires: #('Fame' 'Moose-Query' 'CollectionExtensions') ];
				package: 'Famix-Core'
					with: [ spec
						file: 'Famix-Core-TudorGirba.279';
						repository: 'http://www.smalltalkhub.com/mc/Moose/Moose/main';
						requires: #('Moose-Core') ];
				package: 'Moose-Query'
					with: [ spec repository: 'http://www.smalltalkhub.com/mc/Moose/Moose/main' ];
				package: 'Famix-Extensions'
					with: [ spec
						repository: 'http://www.smalltalkhub.com/mc/Moose/Moose/main';
						requires: #('Famix-Core') ];
				package: 'Famix-Implementation'
					with: [ spec
						repository: 'http://www.smalltalkhub.com/mc/Moose/Moose/main';
						requires: #('Famix-Core') ].
			"project: 'Famix' with: [
				spec
					className: #ConfigurationOfMoose;
					versionString: #development;
					repository: 'http://www.smalltalkhub.com/mc/Moose/Moose/main';
					loads: #( 'Moose-Core' 'Famix-Core' 'Moose-Query' 'Famix-Extensions' 'Famix-Implementation') ]."
			spec
				package: 'OpenPonk-UML-Model' with: [ spec requires: #('Fame' 'famix') ];
				package: 'OpenPonk-UML-DSL'
					with: [ spec requires: #('OpenPonk-UML-Model' 'Famix-Core' 'PetitParser') ];
				package: 'OpenPonk-UML-DI' with: [ spec requires: #('Fame') ];
				package: 'OpenPonk-UML-XMI'
					with: [ spec
						requires:
							#('OpenPonk-UML-Model' 'OpenPonk-UML-DSL' 'OpenPonk-UML-DI' 'XMLParser' 'XPath' 'XMLDOMVisitor') ];
				package: 'UML-CodeGenerator'
					with: [ spec requires: #('OpenPonk-UML-Model' 'OpenPonk-UML-DSL' 'famix' 'Merlin') ];
				package: 'UMLClassEditor-Cormas' with: [ spec requires: #('Moose-Core') ];
				package: 'OpenPonk-ClassEditor'
					with: [ spec
						requires:
							#('OpenPonk-UML-DI' 'OpenPonk-UML-DSL' 'OpenPonk-UML-Model' 'OpenPonk-UML-XMI' 'UMLClassEditor-Cormas' 'Fame' 'famix') ].
			spec group: 'famix' with: #('Famix-Core' 'Famix-Extensions' 'Famix-Implementation').
			spec group: 'plugin' with: #('OpenPonk-ClassEditor' 'UML-CodeGenerator').
			spec group: 'default' with: #('plugin' 'OpenPonk') ]