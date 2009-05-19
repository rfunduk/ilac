Ilac v0.1 - Flex 3 Color Wheel
==============================

It turns out that finding a Flex 3 color wheel component is pretty tough.
[I][0] came across some classes written by [Mario Klingemann][1] and
[Ryan Taylor][2] that looked promising and so here I've put together a
component which uses these.

Usage
-----

See `test/ItsLikeACircle.mxml` for example usage. The short version is you can
listen for `change` (technically [ColorPickerEvent.CHANGE][3]) and `close`
(technically [Event.CLOSE][4]) which do the usual things. `close` is dispatched
on [MouseEvent.ROLL_OUT][5] and `change` any time the color changes.

Building
--------

So to try this out simply run, from within the project root, `test/build.sh`
(make sure `build.sh` is `+x`'d). This will put `ItsLikeACircle.swf` into
`test` where `index.html` already exists. Open `index.html` in your browser
and you should see the simple example.

Contributions Welcome!
----------------------

Please feel free to fork this or submit a patch or whatever. Also feel free to
report serious bugs in the [Issue Tracker][6] here on GitHub.

[0]: http://ryanfunduk.com
[1]: http://quasimondo.com
[2]: http://boostworthy.com
[3]: http://livedocs.adobe.com/flex/gumbo/langref/mx/events/ColorPickerEvent.html#CHANGE
[4]: http://livedocs.adobe.com/flex/gumbo/langref/flash/events/Event.html#CLOSE
[5]: http://livedocs.adobe.com/flex/gumbo/langref/flash/events/MouseEvent.html#ROLL_OUT
[6]: http://github.com/thenduks/ilac/issues
