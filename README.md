followed this guide: https://haxe.org/documentation/platforms/python.html

# Adding a Primop

## Creating the Primop

To add a primop, create a class in the package `interpreter.impl` that extends the `Primop` interface. It needs to implement the `apply` method, which takes an `Array<Value>` and returns a `Value`.

```
class YourPrimop implements Primop {
    public function apply(args:Array<Value>):Value {
        return NumV(0);
    }
}
```

Odds are, you have a good idea of what particular values and number of values should be in the input. You can use that context to build a smart switch statement that uses a specific pattern match to extract the specific values you want from the args. For the default case, you probably just want to throw an error, since your pattern not matching probably means the args aren't valid for this primop. Here's what the addition primop looks like:

```
package interpreter.impl;

import haxe.Exception;

class PlusPrimop implements Primop {
    public function apply(args:Array<Value>):Value {
        switch args {
            case [NumV(a), NumV(b)]:
                return NumV(a + b);
            case _:
                throw new Exception('QWJZ: Invalid arguments for + $args');
        }
    }

    public function new() {}
}
```

It checks that `args` is an array with two elements, both of which are `NumV`. It then adds the numbers and returns them wrapped in a `NumV`. If the pattern doesn't match, it throws an error that says the name of the primop and the args that caused the error.

Note that the class also has a public constructor that takes no arguments. We need this constructor so that we can add it to the `EnvironmentFactory`.

## Adding the Primop to the Environment

The `EnvironmentFactory` class, in the `factory` package, handles environment creation. To add your primop, there are two things you need to do.

1. Add the symbol for your primop to the `INITIAL_SYMBOLS` field as a string. For example, for the addition primop, this would be a simple `"+"`.

2. Add the primop to the `INITIAL_PRIMOPS` field. To do this, you need to wrap an instance of the primop in a `PrimopV` like this: `PrimopV(new PlusPrimop())`.

Make sure that the index of the symbol in the symbols list matches the index of the `PrimopV` in the primops list. Assuming your indexes match, your primop is now available when you make calls to `topInterp` from the main class.
