import tokenizer.Tokenizer;
import factory.EnvironmentFactory;
import parser.Parser;
import interpreter.Interpreter;

class Main {
  public static function main() {
    Sys.println(topInterp("{{proc {a b} {if {<= a b} 1 0}} 1 1}"));

    Sys.println(topInterp('"foobar"'));
    Sys.println(topInterp("*"));
    Sys.println(topInterp("{proc {} 0}"));

    Sys.println(topInterp("{{proc {a b} {* a b}} 5 3}"));

    Sys.println(topInterp("{declare {[a 5] [b 7]} in {* a b}}"));
  
    Sys.println(topInterp('{declare {[f {proc {f n} {if {<= n 1} 1 {* n {f f {- n 1}}}}}]} in {f f 6}}'));

    //Sys.println(topInterp("{read-num}"));
    //Sys.println(topInterp("{read-str}"));
    Sys.println(topInterp("{equal? 1 2}"));
    Sys.println(topInterp('{++ "this " "Should work"}'));
    Sys.println(topInterp('{seq "this" "Should work"}'));

    Sys.println(topInterp('{++ 0 1 2 3 4}'));

    // Super long line, our parser probably doesn't handler new lines. This is
    // the example program we submitted as part of assignment 5, with newlines
    // removed.
    // Sys.println(topInterp('{declare    {[welcome      {proc       {}       {seq        {println "Welcome to the Fitness Tracker Application!"}        {println "To begin, you must specify the following:"}        {println " - Participant\'s name"}        {println " - Participant\'s age"}        {println " - Participant\'s height (inches)"}        {println " - Participant\'s weight (pounds)"}        {println " - Exercise duration (minutes)"}        {println " - Exercise type (1-4)"}        {println "The application will calculate the burned calories and BMI."}}}]     [get-name {proc {} {seq {println "Enter name:"} {read-str}}}]     [is-nonnegative? {proc {x} {<= 0 x}}]     [get-num-with-prompt      {proc       {prompt predicate}       {declare {[value {seq                         {println prompt}                         {read-num}}]}                in {if                    {predicate value}                    value                    {error {++ "Invalid response " value}}}}}]     [get-exercise-type      {proc       {}       {seq        {println "Enter exercise type (1-4):"}        {println " 1: low impact"}        {println " 2: high impact"}        {println " 3: slow paced"}        {println " 4: fast paced"}        {declare         {[choice {read-num}]}         in         {if          {equal? choice 1}          choice          {if           {equal? choice 2}           choice           {if            {equal? choice 3}            choice            {if             {equal? choice 4}             choice             {error {++ "Invalid choice " choice}}}}}}}}}]     [convert-lb-to-kg {proc {lbs} {* lbs 0.45359237}}]     [compute-met      {proc       {type}       {if        {equal? type 1}        5        {if         {equal? type 2}         7         {if          {equal? type 3} 3 4}}}}]     [compute-calories-burned {proc {duration kgs met}                                    {/ {* 3.5 {* duration {* met kgs}}} 200}}]     [compute-bmi {proc {lbs inches} {/ {* 703 lbs} {* inches inches}}}]     [bmi-category      {proc       {bmi}       {if        {<= bmi 18.59}        "Under Weight"        {if         {<= bmi 25}         "Normal Weight"         {if          {<= bmi 30}          "Over Weight"          "Obesity"}}}}]     [compute-equivalent-miles      {proc       {height type duration}       {declare        {[steps-per-minute          {if           {equal? type 1}           120           {if            {equal? type 2}            227            {if             {equal? type 3} 100 152}}}]         [one-step {/ {* 0.413 height} 12}]}        in        {declare         {[total-steps {* steps-per-minute one-step}]}         in         {/ {* one-step total-steps} 5280}}}}]}    in    {seq     {welcome}     {declare      {[name {get-name}]       [age {get-num-with-prompt "Enter age:" is-nonnegative?}]       [height {get-num-with-prompt "Enter height (inches):" is-nonnegative?}]       [weight {get-num-with-prompt "Enter weight (lbs):" is-nonnegative?}]       [exercise-type {get-exercise-type}]       [duration {get-num-with-prompt "Enter duration (minutes):" is-nonnegative?}]}      in      {declare       {[bmi {compute-bmi weight height}]        [calories-burned         {compute-calories-burned          duration          {convert-lb-to-kg weight}          {compute-met exercise-type}}]        [miles {compute-equivalent-miles height exercise-type duration}]}       in       {seq        {println {++ "Name: " name}}        {println {++ "Age: " age}}        {println {++ "Height: " height " inches"}}        {println {++ "Weight: " weight " lbs"}}        {println {++ "Equivalent miles: " miles}}        {println {++ "BMI: " bmi}}        {println {++ "BMI Category: " {bmi-category bmi}}}        {++ "All done!"}}}}}}'));
  }

  public static function topInterp(program:String) {
    final tokenized = Tokenizer.tokenize(program);
    final parsed = Parser.parse(tokenized);
    final env = EnvironmentFactory.getEnvironment();
    final result = Interpreter.interp(parsed, env);

    return serialization.Serializer.serialize(result);
  }
}
