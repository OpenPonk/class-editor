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
					repository: 'http://smalltalkhub.com/mc/Moose/PetitParser/main/' ].
		spec 
			package: 'DynaCASE-ClassEditor' with: [
				spec requires: #('DynaCASE' 'PetitParser' ). ];
			package: 'DynaCASE-UMLDI'.
		spec group: 'default' with: #('DynaCASE-ClassEditor' 'DynaCASE-UMLDI' ). ]
