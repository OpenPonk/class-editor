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
			project: 'MooseCore' with: [
				spec
					className: #ConfigurationOfMoose;
					version: #minimal;
					repository: 'http://smalltalkhub.com/mc/Moose/Moose/main/'
			].
		spec 
			package: 'DynaCASE-UML-Model' with: [
				spec requires: #('MooseCore')
			];
			package: 'DynaCASE-UML-DSL' with: [
				spec requires: #('DynaCASE-UML-Model' 'PetitParser')
			];
			package: 'DynaCASE-UML-DI';
			package: 'DynaCASE-Generator' with: [
				spec requires: #('DynaCASE-UML-Model' 'DynaCASE-UML-DSL')
			];
			package: 'DynaCASE-ClassEditor' with: [
				spec requires: #('DynaCASE' 'DynaCASE-UML-DI' 'DynaCASE-UML-DSL' 'DynaCASE-UML-Model' ) ].
		spec group: 'default' with: #('DynaCASE-ClassEditor' 'DynaCASE-Generator'). ]
