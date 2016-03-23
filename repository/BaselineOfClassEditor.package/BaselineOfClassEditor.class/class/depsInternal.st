as yet unclassified
depsInternal
	<script>
	|deps b|
deps := {
#Generator -> #'UML-Model'.
#Generator -> #'UML-DSL'.

#ClassEditor -> #'UML-Model'.
#ClassEditor -> #'UML-DI'.
#ClassEditor -> #'UML-DSL'.

#'UML-DSL' -> #'UML-Model'.
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