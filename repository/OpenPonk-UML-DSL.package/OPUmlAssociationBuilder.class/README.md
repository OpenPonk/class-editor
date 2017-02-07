<association> ::= <source-class> [ <multiplicity> ] [ <source-name> ]
<type>
[ <target-name> ] <target-class> [ <multiplicity> ]
[ ':' <association-name> ].

<type> ::= <start-symbol> [ '-' ]*  <end-symbol>
<start-symbol> ::= <type-symbol> | '<'
<end-symbol> ::= <type-symbol> | '>'
<type-symbol> ::=  '-' | '<>' | '<*>'