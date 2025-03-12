package serialization;

import interpreter.Value;

class Serializer {
    public static function serialize(value:Value):String {
        switch value {
            case NumV(n):
                return '$n';
            case StringV(string):
                return '"$string"';
            case PrimopV(_):
                return "#<primop>";
            case CloV(_, _, _):
                return "#<procedure>";
            case BoolV(bool):
                return '$bool';
        }
    }

    public static function prettySerialize(value:Value):String {
        switch value {
            case StringV(string):
                return string;
            case _:
                return serialize(value);
        }
    }
}
