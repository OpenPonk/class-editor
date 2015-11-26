accessing
baseline: spec
	<baseline>
	spec for: #'common' do: [
		spec
			baseline: 'DynaCASE' with: [ 
				spec
					repository: 'github://dynacase/dynacase/repository' ].
		spec
			project: 'PetitParser' with: [ 
				spec
					className: #ConfigurationOfPetitParser;
					versionString: #development;
					loads: #('Parser');
					repository: 'http://smalltalkhub.com/mc/Moose/PetitParser/main/' ];
			project: 'Fame-Core' with: [
				spec
					className: #ConfigurationOfFame;
					versionString: #'development';
					repository: 'http://www.smalltalkhub.com/mc/Moose/Fame/main' ];
			project: 'Famix-Core' with: [
				spec
					className: #ConfigurationOfMoose;
					versionString: #'development';
					loads: #('Famix-Core Moose-Core');
					repository: 'http://www.smalltalkhub.com/mc/Moose/Moose/main' ];
			project: 'Moose-Core' with: [
				spec
					className: #ConfigurationOfMoose;
					version: #development;
					loads: #('Moose-Core' 'Moose-Query');
					repository: 'http://smalltalkhub.com/mc/Moose/Moose/main/'
			].
		spec 
			package: 'DynaCASE-UML-Model' with: [
				spec requires: #('Fame-Core' 'Famix-Core' 'Moose-Core')
			];
			package: 'DynaCASE-UML-DSL' with: [
				spec requires: #('DynaCASE-UML-Model' 'Famix-Core' 'Moose-Core' 'PetitParser')
			];
			package: 'DynaCASE-UML-DI' with: [
				spec requires: #('Fame-Core')
			];
			package: 'DynaCASE-Generator' with: [
				spec requires: #('DynaCASE-UML-Model' 'DynaCASE-UML-DSL' 'Famix-Core')
			];
			package: ''
			package: 'DynaCASE-ClassEditor' with: [
				spec requires: #('DynaCASE' 'DynaCASE-UML-DI' 'DynaCASE-UML-DSL' 'DynaCASE-UML-Model' 'Fame-Core' 'Famix-Core' 'Moose-Core' ) ].
		spec group: 'default' with: #('DynaCASE-ClassEditor' 'DynaCASE-Generator'). ]
