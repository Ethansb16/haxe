package interpreter.impl;

import serialization.Serializer;
import haxe.Exception;

class JoinPrimop implements Primop {
    public function apply(args:Array<Value>):Value {
        if (args.length == 0) {
            throw new Exception('QWJZ: Invalid arguments for ++ $args');
        }

        return StringV(args.map(Serializer.prettySerialize).join(""));
    }

    public function new() {}
}
