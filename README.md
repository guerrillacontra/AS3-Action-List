AS3-Action-List
===============

A preferred alternative to a hierarchical finite state machine. 

Each "Action" allows us to encapsulate a specifc type of behaviour that could
be processed over many frames. (similar to the command design pattern).

An action list allows us to assign "lanes" via a bit-mask so that we can
describe what "kind" of behaviour the action represents.

Some example lane's:
- Animation
- AI
- Motion

These lanes are very useful to us, as they allow actions to be blocked and or block
other actions via a "lanes to block mask".

Finally we can communicate between actions that share the same parent "list" by
reading/writing to a blackboard.

The blackboard is a simple data structure that can stored "entries" so that the action's
can pass data between them.

# Examples

