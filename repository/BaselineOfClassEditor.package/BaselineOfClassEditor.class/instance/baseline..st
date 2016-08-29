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
				project: 'XMLDOMVisitor'
				with: [ spec
						className: #ConfigurationOfXmlDomVisitor;
						versionString: #development;
						repository: 'http://smalltalkhub.com/mc/peteruhnak/XmlDomVisitor/main/' ].
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
					versionString: #'development';
					repository: 'http://www.smalltalkhub.com/mc/Moose/Merlin/main' ].
			spec
				baseline: 'DynaCASE'
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
				package: 'DynaCASE-UML-Model' with: [ spec requires: #('Fame' 'famix') ];
				package: 'DynaCASE-UML-DSL'
					with: [ spec requires: #('DynaCASE-UML-Model' 'Famix-Core' 'PetitParser') ];
				package: 'DynaCASE-UML-DI' with: [ spec requires: #('Fame') ];
				package: 'DynaCASE-UML-XMI'
					with: [ spec
						requires:
							#('DynaCASE-UML-Model' 'DynaCASE-UML-DSL' 'DynaCASE-UML-DI' 'XMLParser' 'XPath' 'XMLDOMVisitor') ];
				package: 'UML-CodeGenerator'
					with: [ spec requires: #('DynaCASE-UML-Model' 'DynaCASE-UML-DSL' 'famix' 'Merlin') ];
				package: 'DynaCASE-ClassEditor'
					with: [ spec
						requires:
							#('DynaCASE-UML-DI' 'DynaCASE-UML-DSL' 'DynaCASE-UML-Model' 'DynaCASE-UML-XMI' 'Fame' 'famix') ].
			spec group: 'famix' with: #('Famix-Core' 'Famix-Extensions' 'Famix-Implementation').
			spec group: 'plugin' with: #('DynaCASE-ClassEditor' 'UML-CodeGenerator').
			spec group: 'default' with: #('plugin' 'DynaCASE') ]