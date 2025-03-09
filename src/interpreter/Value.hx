package interpreter;

import interpreter.Primop;
import parser.ExprC;

enum Value {
    NumV(n:Float);
    StringV(string:String);
    BoolV(bool:Bool);
    CloV(args:Array<String>, body:ExprC, env:Environment);
    PrimopV(op:Primop);
}
