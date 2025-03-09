package parser;

enum ExprC {
    NumC(n:Float);
    StringC(string:String);
    IdC(symbol:String);
    IfC(condition:ExprC, ifTrue:ExprC, ifFalse:ExprC);
    ProcC(args:Array<String>, body:ExprC);
    AppC(proc:ExprC, args:Array<ExprC>);
}
