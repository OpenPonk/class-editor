as yet unclassified
deps
	<script>
	|deps b|
deps := {
#Generator -> #'UML-Model'.
#Generator -> #'UMLDSL'.
#Generator -> #'Famix-Core'.

#'UML-Model' -> #'Fame-Core'.
#'UML-Model' -> #'Famix-Core'.
#'UML-Model' -> #'Magritte-Model'.
#'UML-Model' -> #'Moose-Core'.

#ClassEditor -> #'DynaCASE-Core'.
#ClassEditor -> #'UML-Model'.
#ClassEditor -> #UMLDI.
#ClassEditor -> #UMLDSL.
#ClassEditor -> #'Fame-Core'.
#ClassEditor -> #'Famix-Core'.
#ClassEditor -> #'Magritte-Model'.
#ClassEditor -> #'Moose-Core'.
#ClassEditor -> #Roassal2.

#UMLDI -> #'Fame-Core'.
#UMLDI -> #Roassal2.

#UMLDSL -> #PetitParser.
#UMLDSL -> #'UML-Model'.
#UMLDSL -> #'Moose-Core'.
#UMLDSL -> #'Famix-Core'.
}.

b := RTMondrian new.
b shape label.
b nodes: ((deps collect: #key),(deps collect: #value)) asSet.
b edges shape arrowedLine.
b edges useAssociations: deps.
b layout sugiyama
	verticalGap: 50;
	horizontalGap: 30.
b build.
b view @ RTZoomableView.
b open