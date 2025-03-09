package interpreter;

interface Primop {
    public function apply(args:Array<Value>):Value;
}
