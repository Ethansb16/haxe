package interpreter;

import parser.ExprC;

enum Value {
    NumV(n:Int);
    StringV(string:String);
    BoolV(bool:Bool);
    CloV(args:Array<String>, body:ExprC, env:Environment);
    // TODO: Add ClosureV and PrimopV
}
