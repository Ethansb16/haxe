package parser;

enum ExprC {
    NumC(n:Int);
    StringC(string:String);
    IdC(symbol:String);
    IfC(condition:ExprC, ifTrue:ExprC, ifFalse:ExprC);
    ProcC(args:Array<ExprC>, body:ExprC);
    AppC(proc:ExprC, args:Array<ExprC>);
}
