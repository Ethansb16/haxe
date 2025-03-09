package parser;

enum Sexp {
    TreeT(nodes:Array<Sexp>);
    LeafT(value:String);
}
