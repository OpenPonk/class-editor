Extension { #name : 'IPIssuesProfileFactory' }

{ #category : '*OpenPonk-ClassEditor-Profiles' }
IPIssuesProfileFactory >> openExample [

	<script: 'self new openExample'>
	(OPProject openOnModel: self exampleModel) showAllElementsInAllDiagrams
]

{ #category : '*OpenPonk-ClassEditor-Profiles' }
IPIssuesProfileFactory >> openProfile [

	<script: 'self new openProfile'>
	(OPProject openOnModel: self class profile) showAllElementsInAllDiagrams
]
