package sx.input;

import hunit.TestCase;
import sx.widgets.Widget;
import sx.input.Pointer;



/**
 * sx.input.Pointer
 *
 */
class PointerTest extends TestCase
{

    @test
    public function pressed_widgetPressed_bubblesOnPressSignal () : Void
    {
        var widget1 = new Widget();
        var widget2 = widget1.addChild(new Widget());
        var widget3 = widget2.addChild(new Widget());

        var dispatchOrder : Array<{processor:Widget, dispatcher:Widget}> = [];
        var callback = function (p, d, i) dispatchOrder.push({processor:p, dispatcher:d});
        widget1.onPointerPress.add(callback);
        widget2.onPointerPress.add(callback);
        widget3.onPointerPress.add(callback);

        Pointer.pressed(widget3);

        assert.similar(
            [
                {processor:widget3, dispatcher:widget3},
                {processor:widget2, dispatcher:widget3},
                {processor:widget1, dispatcher:widget3},
            ],
            dispatchOrder
        );
    }


    @test
    public function pressed_signalInterrupted_stopBubblingOnPressSignal () : Void
    {
        var widget1 = new Widget();
        var widget2 = widget1.addChild(new Widget());
        var widget3 = widget2.addChild(new Widget());

        var dispatchOrder : Array<{processor:Widget, dispatcher:Widget}> = [];
        var callback = function (p, d, i) {
            dispatchOrder.push({processor:p, dispatcher:d});
            if (p == widget2) Pointer.stopCurrentSignal();
        }
        widget1.onPointerPress.add(callback);
        widget2.onPointerPress.add(callback);
        widget3.onPointerPress.add(callback);

        Pointer.pressed(widget3);

        assert.similar(
            [
                {processor:widget3, dispatcher:widget3},
                {processor:widget2, dispatcher:widget3}
            ],
            dispatchOrder
        );
    }


    @test
    public function pressed_initialWidgetDisabled_startsDispatchingFromFirstEnabledWidget () : Void
    {
        var widget1 = new Widget();
        var widget2 = widget1.addChild(new Widget());
        var widget3 = widget2.addChild(new Widget());
        widget2.enabled = false;

        var dispatchOrder : Array<{processor:Widget, dispatcher:Widget}> = [];
        var callback = function (p, d, i) dispatchOrder.push({processor:p, dispatcher:d});
        widget1.onPointerPress.add(callback);
        widget2.onPointerPress.add(callback);
        widget3.onPointerPress.add(callback);

        Pointer.pressed(widget3);

        assert.similar(
            [
                {processor:widget1, dispatcher:widget1}
            ],
            dispatchOrder
        );
    }


    @test
    public function released_widgetReleased_bubblesOnReleaseSignal () : Void
    {
        var widget1 = new Widget();
        var widget2 = widget1.addChild(new Widget());
        var widget3 = widget2.addChild(new Widget());

        var dispatchOrder : Array<{processor:Widget, dispatcher:Widget}> = [];
        var callback = function (p, d, i) dispatchOrder.push({processor:p, dispatcher:d});
        widget1.onPointerRelease.add(callback);
        widget2.onPointerRelease.add(callback);
        widget3.onPointerRelease.add(callback);

        Pointer.released(widget3);

        assert.similar(
            [
                {processor:widget3, dispatcher:widget3},
                {processor:widget2, dispatcher:widget3},
                {processor:widget1, dispatcher:widget3},
            ],
            dispatchOrder
        );
    }


    @test
    public function released_signalInterrupted_stopBubblingOnReleaseSignal () : Void
    {
        var widget1 = new Widget();
        var widget2 = widget1.addChild(new Widget());
        var widget3 = widget2.addChild(new Widget());

        var dispatchOrder : Array<{processor:Widget, dispatcher:Widget}> = [];
        var callback = function (p, d, i) {
            dispatchOrder.push({processor:p, dispatcher:d});
            if (p == widget2) Pointer.stopCurrentSignal();
        }
        widget1.onPointerRelease.add(callback);
        widget2.onPointerRelease.add(callback);
        widget3.onPointerRelease.add(callback);

        Pointer.released(widget3);

        assert.similar(
            [
                {processor:widget3, dispatcher:widget3},
                {processor:widget2, dispatcher:widget3}
            ],
            dispatchOrder
        );
    }


    @test
    public function released_hasPreviouslyPressedWidgets_dispatchesOnTapSignalForSequentiallyPressedAndReleasedWidgets () : Void
    {
        var root1  = new Widget();
        var child1 = root1.addChild(new Widget());
        var child2 = child1.addChild(new Widget());
        Pointer.pressed(child2);

        var root2 = new Widget();
        root2.addChild(child1);

        var dispatchOrder : Array<{processor:Widget, dispatcher:Widget}> = [];
        var callback = function (p, d, i) dispatchOrder.push({processor:p, dispatcher:d});
        root1.onPointerTap.add(callback);
        root2.onPointerTap.add(callback);
        child1.onPointerTap.add(callback);
        child2.onPointerTap.add(callback);

        Pointer.released(child2);
        Pointer.released(root1);

        assert.similar(
            [
                {processor:child2, dispatcher:child2},
                {processor:child1, dispatcher:child2}
            ],
            dispatchOrder
        );
    }


    @test
    public function released_initialWidgetDisabled_startsDispatchingFromFirstEnabledWidget () : Void
    {
        var widget1 = new Widget();
        var widget2 = widget1.addChild(new Widget());
        var widget3 = widget2.addChild(new Widget());
        widget2.enabled = false;

        var dispatchOrder : Array<{processor:Widget, dispatcher:Widget}> = [];
        var callback = function (p, d, i) dispatchOrder.push({processor:p, dispatcher:d});
        widget1.onPointerRelease.add(callback);
        widget2.onPointerRelease.add(callback);
        widget3.onPointerRelease.add(callback);

        Pointer.released(widget3);

        assert.similar(
            [
                {processor:widget1, dispatcher:widget1}
            ],
            dispatchOrder
        );
    }


    @test
    public function moved_overNotPreviouslyHoveredWidgets_bubblesOnPointerOver () : Void
    {
        var widget1 = new Widget();
        var widget2 = widget1.addChild(new Widget());
        var widget3 = widget2.addChild(new Widget());

        var dispatchOrder : Array<{processor:Widget, dispatcher:Widget}> = [];
        var callback = function (p, d, i) dispatchOrder.push({processor:p, dispatcher:d});
        widget1.onPointerOver.add(callback);
        widget2.onPointerOver.add(callback);
        widget3.onPointerOver.add(callback);

        Pointer.moved(widget3);

        assert.similar(
            [
                {processor:widget3, dispatcher:widget3},
                {processor:widget2, dispatcher:widget3},
                {processor:widget1, dispatcher:widget3},
            ],
            dispatchOrder
        );
    }


    @test
    public function moved_initialWidgetDisabled_startsDispatchingFromFirstEnabledWidget () : Void
    {
        var widget1 = new Widget();
        var widget2 = widget1.addChild(new Widget());
        var widget3 = widget2.addChild(new Widget());
        widget2.enabled = false;

        var dispatchOrder : Array<{processor:Widget, dispatcher:Widget}> = [];
        var callback = function (p, d, i) dispatchOrder.push({processor:p, dispatcher:d});
        widget1.onPointerOver.add(callback);
        widget2.onPointerOver.add(callback);
        widget3.onPointerOver.add(callback);

        Pointer.moved(widget3);

        assert.similar(
            [
                {processor:widget1, dispatcher:widget1}
            ],
            dispatchOrder
        );
    }


    @test
    public function moved_overNotPreviouslyHoveredWidgetsAndSignalInterruptet_stopBubblingOnPointerOverSignal () : Void
    {
        var widget1 = new Widget();
        var widget2 = widget1.addChild(new Widget());
        var widget3 = widget2.addChild(new Widget());

        var dispatchOrder : Array<{processor:Widget, dispatcher:Widget}> = [];
        var callback = function (p, d, i) {
            dispatchOrder.push({processor:p, dispatcher:d});
            if (p == widget2) Pointer.stopCurrentSignal();
        }
        widget1.onPointerOver.add(callback);
        widget2.onPointerOver.add(callback);
        widget3.onPointerOver.add(callback);

        Pointer.moved(widget3);

        assert.similar(
            [
                {processor:widget3, dispatcher:widget3},
                {processor:widget2, dispatcher:widget3}
            ],
            dispatchOrder
        );
    }


    @test
    public function moved_outOfPreviouslyHoveredWidgets_bubblesOnPointerOut () : Void
    {
        var widget1 = new Widget();
        var widget2 = widget1.addChild(new Widget());
        var widget3 = widget2.addChild(new Widget());
        Pointer.moved(widget3);

        var dispatchOrder : Array<{processor:Widget, dispatcher:Widget}> = [];
        var callback = function (p, d, i) dispatchOrder.push({processor:p, dispatcher:d});
        widget1.onPointerOut.add(callback);
        widget2.onPointerOut.add(callback);
        widget3.onPointerOut.add(callback);

        Pointer.moved(null);

        assert.similar(
            [
                {processor:widget3, dispatcher:widget3},
                {processor:widget2, dispatcher:widget3},
                {processor:widget1, dispatcher:widget3},
            ],
            dispatchOrder
        );
    }


    @test
    public function moved_outOfPreviouslyHoveredWidgetsAndSignalInterruptet_stopBubblingOnPointerOutSignal () : Void
    {
        var widget1 = new Widget();
        var widget2 = widget1.addChild(new Widget());
        var widget3 = widget2.addChild(new Widget());
        Pointer.moved(widget3);

        var dispatchOrder : Array<{processor:Widget, dispatcher:Widget}> = [];
        var callback = function (p, d, i) {
            dispatchOrder.push({processor:p, dispatcher:d});
            if (p == widget2) Pointer.stopCurrentSignal();
        }
        widget1.onPointerOut.add(callback);
        widget2.onPointerOut.add(callback);
        widget3.onPointerOut.add(callback);

        Pointer.moved(null);

        assert.similar(
            [
                {processor:widget3, dispatcher:widget3},
                {processor:widget2, dispatcher:widget3}
            ],
            dispatchOrder
        );
    }


    @test
    public function moved_overSomeWidgets_bubblesOnPointerMoveSignal () : Void
    {
        var widget1 = new Widget();
        var widget2 = widget1.addChild(new Widget());
        var widget3 = widget2.addChild(new Widget());

        var dispatchOrder : Array<{processor:Widget, dispatcher:Widget}> = [];
        var callback = function (p, d, i) dispatchOrder.push({processor:p, dispatcher:d});
        widget1.onPointerMove.add(callback);
        widget2.onPointerMove.add(callback);
        widget3.onPointerMove.add(callback);

        Pointer.moved(widget3);

        assert.similar(
            [
                {processor:widget3, dispatcher:widget3},
                {processor:widget2, dispatcher:widget3},
                {processor:widget1, dispatcher:widget3},
            ],
            dispatchOrder
        );
    }


    @test
    public function moved_overSomeWidgetsAndSignalInterrupted_stopBubblingOnPointerMoveSignal () : Void
    {
        var widget1 = new Widget();
        var widget2 = widget1.addChild(new Widget());
        var widget3 = widget2.addChild(new Widget());

        var dispatchOrder : Array<{processor:Widget, dispatcher:Widget}> = [];
        var callback = function (p, d, i) {
            dispatchOrder.push({processor:p, dispatcher:d});
            if (p == widget2) Pointer.stopCurrentSignal();
        }
        widget1.onPointerMove.add(callback);
        widget2.onPointerMove.add(callback);
        widget3.onPointerMove.add(callback);

        Pointer.moved(widget3);

        assert.similar(
            [
                {processor:widget3, dispatcher:widget3},
                {processor:widget2, dispatcher:widget3},
            ],
            dispatchOrder
        );
    }


    @test
    public function touchId_generatedForMouse_TouchIdKeptTheSameFromPressTillRelease () : Void
    {
        var touchId = 0;
        var keptTheSame = true;
        var widget = new Widget();
        widget.onPointerPress.add(function (p, d, id) touchId = id);
        widget.onPointerMove.add(function (p, d, id) keptTheSame = (touchId == id));
        widget.onPointerRelease.add(function (p, d, id) keptTheSame = (touchId == id));

        //mouse events allowed to not pass touchId to Pointer
        Pointer.pressed(widget);
        Pointer.moved(widget);
        Pointer.released(widget);

        assert.isTrue(keptTheSame);
        assert.notEqual(0, touchId);
    }

}//class PointerTest