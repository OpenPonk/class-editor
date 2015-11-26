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
			project: 'Fame' with: [
				spec
					className: #ConfigurationOfFame;
					versionString: #'development';
					repository: 'http://www.smalltalkhub.com/mc/Moose/Fame/main' ];
			project: 'Famix' with: [
				spec
					className: #ConfigurationOfMoose;
					versionString: #'development';
					loads: #('Famix-Core' 'Moose-Core' 'Moose-Query' 'Famix-Extensions');
					repository: 'http://www.smalltalkhub.com/mc/Moose/Moose/main' ].
		spec 
			package: 'DynaCASE-UML-Model' with: [
				spec requires: #('Fame' 'Famix')
			];
			package: 'DynaCASE-UML-DSL' with: [
				spec requires: #('DynaCASE-UML-Model' 'Famix' 'PetitParser')
			];
			package: 'DynaCASE-UML-DI' with: [
				spec requires: #('Fame')
			];
			package: 'DynaCASE-Generator' with: [
				spec requires: #('DynaCASE-UML-Model' 'DynaCASE-UML-DSL' 'Famix')
			];
			package: 'DynaCASE-ClassEditor' with: [
				spec requires: #('DynaCASE' 'DynaCASE-UML-DI' 'DynaCASE-UML-DSL' 'DynaCASE-UML-Model' 'Fame' 'Famix' ) ].
		spec group: 'default' with: #('DynaCASE-ClassEditor' 'DynaCASE-Generator'). ]
