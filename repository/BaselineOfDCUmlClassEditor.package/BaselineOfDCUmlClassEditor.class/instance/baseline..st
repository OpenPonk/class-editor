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
			package: 'DynaCASE-UMLDI';
			package: 'DynaCASE-Generator';
			package: 'DynaCASE-ClassEditor' with: [
				spec requires: #('DynaCASE' 'PetitParser' 'DynaCASE-UMLDI' 'DynaCASE-Generator' ). ].
		spec group: 'default' with: #('DynaCASE-UMLDI' 'DynaCASE-ClassEditor' 'DynaCASE-Generator'). ]
