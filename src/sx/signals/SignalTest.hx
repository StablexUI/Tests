package sx.signals;

import hunit.TestCase;
import sx.widgets.Widget;



/**
 * sx.signals.Signal
 *
 */
class SignalTest extends TestCase
{

    @test
    public function unique_listenerNotAttachedYet_attachesListener () : Void
    {
        var listener = function(w) {};
        var signal   = new Signal<Widget->Void>();

        signal.unique(listener);

        assert.equal(1, signal.listenersCount);
    }


    @test
    public function unique_listenerAlreadyAttached_doesNotAttachListener () : Void
    {
        var listener = function(w) {};
        var signal   = new Signal<Widget->Void>();
        signal.unique(listener);

        signal.unique(listener);

        assert.equal(1, signal.listenersCount);
    }


    @test
    public function invoke_listenerIsNotAttachedYet_attachesListener () : Void
    {
        var listener = function(w) {};
        var signal   = new Signal<Widget->Void>();

        signal.add(listener);

        assert.equal(1, signal.listenersCount);
    }


    @test
    public function invoke_listenerIsAlreadyAttached_attachesAgain () : Void
    {
        var listener = function(w) {};
        var signal   = new Signal<Widget->Void>();
        signal.add(listener);

        signal.add(listener);

        assert.equal(2, signal.listenersCount);
    }


    @test
    public function dontinvoke_listenerIsNotAttached_doesNotRemoveAnything () : Void
    {
        var listener = function(w) {};
        var signal   = new Signal<Widget->Void>();
        signal.add(function(w) {});

        signal.remove(listener);

        assert.equal(1, signal.listenersCount);
    }


    @test
    public function dontinvoke_listenerIsAttached_removesListener () : Void
    {
        var listener = function(w) {};
        var signal   = new Signal<Widget->Void>();
        signal.add(listener);

        signal.remove(listener);

        assert.equal(0, signal.listenersCount);
    }


    @test
    public function willInvoke_listenerIsAttached_returnsTrue () : Void
    {
        var listener = function(w) {};
        var signal   = new Signal<Widget->Void>();
        signal.add(listener);

        var willInvoke = signal.will(listener);

        assert.isTrue(willInvoke);
    }


    @test
    public function willInvoke_listenerIsNotAttached_returnsFalse () : Void
    {
        var listener = function(w) {};
        var signal   = new Signal<Widget->Void>();

        var willInvoke = signal.will(listener);

        assert.isFalse(willInvoke);
    }


    @test
    public function dispatch_listenersListIsNotChangedDuringDispatch_allListenersCalled () : Void
    {
        var signal = new Signal<Widget->Void>();
        var listenersCalled = 0;
        for (i in 0...10) {
            signal.add(function(dispatcher:Widget) listenersCalled++);
        }

        signal.dispatch(new Widget());

        assert.equal(10, listenersCalled);
    }


    @test
    public function dispatch_someListenersRemovedDuringDispatch_allListenersCalled () : Void
    {
        var signal = new Signal<Widget->Void>();
        var listenersCalled = 0;
        var listeners = [];

        for (i in 0...10) {
            listeners.push(
                function(w) {
                    listenersCalled++;
                    if (listenersCalled % 2 == 0) {
                        signal.remove(listeners[listeners.length - listenersCalled]);
                    }
                }
            );
            signal.add(listeners[i]);
        }

        signal.dispatch(new Widget());

        assert.equal(10, listenersCalled);
    }


    @test
    public function dispatch_someListenersAddedDuringDispatch_newListenersNotCalled () : Void
    {
        var signal = new Signal<Widget->Void>();
        var newListenerCalled = false;
        var newListener = function(w) newListenerCalled = true;

        for (i in 0...2) {
            signal.add(function(w) signal.add(newListener));
        }

        signal.dispatch(new Widget());

        assert.isFalse(newListenerCalled);
    }


    @test
    public function bubbleDispatch_severalLevelsDeepDisplayList_listenersCalledWithCorrectArguments () : Void
    {
        var root   = new Widget();
        var parent = new BubbleTestWidget();
        var child  = new BubbleTestWidget();
        root.addChild(parent);
        parent.addChild(child);

        parent.onBubble.add(function (processor, dispatcher) {
            assert.equal(processor, parent);
            assert.equal(dispatcher, child);
        });
        child.onBubble.add(function (processor, dispatcher) {
            assert.equal(processor, child);
            assert.equal(dispatcher, child);
        });

        child.onBubble.bubbleDispatch(onBubble, child);
    }

}//class SignalTest




private class BubbleTestWidget extends Widget {
    public var onBubble : Signal<BubbleTestWidget->BubbleTestWidget->Void>;

    public function new ()
    {
        super();
        onBubble = new Signal();
    }
}