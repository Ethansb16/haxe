package interpreter;

import factory.EnvironmentFactory;
import haxe.Exception;
import haxe.exceptions.NotImplementedException;
import parser.ExprC;

class Interpreter {
    public static function interp(expr:ExprC, env:Environment):Value {
        switch expr {
            case NumC(n):
                return NumV(n);
            case StringC(string):
                return StringV(string);
            case IdC(symbol):
                return env.lookup(symbol);
            case ProcC(args, body):
                return CloV(args, body, env);
            case AppC(proc, args):
                final closure = interp(proc, env);
                return handleClosure(closure, args.map(e -> interp(e, env)));
            case _:
                throw new NotImplementedException('Cannot interpret $expr');
        }
    }

    private static function handleClosure(closure:Value, passedArgs:Array<Value>):Value {
        switch closure {
            case CloV(requiredArgs, body, env):
                final extendedEnv = env.extend(requiredArgs, passedArgs);
                return interp(body, extendedEnv);
            case PrimopV(op):
                return op.apply(passedArgs);
            case _:
                throw new Exception('QWJZ: expected a closure, got $closure');
        }
    }
}
