as yet unclassified
writeClassesIn: aModel
	(self sortedHierarchyFor: aModel allClasses)
		do: [ :each | 
			writer
				tag: 'class'
				with: [ writer
						tag: 'name' with: each name;
						tag: 'environment' with: environment;
						tag: 'super' with: (self superClassFor: each);
						tag: 'private' with: 'false';
						tag: 'indexed-type' with: 'none';
						tag: 'inst-vars'
							with: (((each attributes reject: #isStatic) collect: #name) joinUsing: ' ');
						tag: 'class-inst-vars'
							with: (((each attributes select: #isStatic) collect: #name) joinUsing: ' ');
						tag: 'imports' with: '';
						tag: 'category' with: packageName , 'Category';
						tag: 'attributes' with: [ writer tag: 'package' with: packageName ] ] ]