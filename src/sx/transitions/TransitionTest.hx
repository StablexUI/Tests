package sx.transitions;

import hunit.TestCase;
import sx.transitions.Transition;
import sx.tween.Tweener;
import sx.widgets.Widget;



/**
 * sx.transitions.Transition
 *
 */
class TransitionTest extends TestCase
{
    /** Parent for transitioned widgets */
    private var parent : Widget;
    /** Widget to hide */
    private var toHide : Widget;
    /** Widget to show */
    private var toShow : Widget;
    /** Default `Tweener.getTime` implementation */
    private var defaultGetTime : Void->Float;
    /** Time counter for test implementation of `Tweener.getTime` */
    private var time : Float = 0;


    /**
     * Setup test environment
     */
    override public function setupTestCase () : Void
    {
        defaultGetTime = Tweener.getTime;
        Tweener.getTime = function () return time;
    }


    /**
     * Cleanup test environment
     */
    override public function tearDownTestCase () : Void
    {
        Tweener.getTime = defaultGetTime;
        defaultGetTime = null;
    }


    /**
     * Simulate time flow
     */
    private function advanceTime () : Void
    {
        time += 0.1;
    }


    /**
     * Setup test environment
     */
    override public function setup () : Void
    {
        parent = new Widget();
        toHide = parent.addChild(new Widget());
        toShow = parent.addChild(new Widget());
        toShow.visible = false;
    }


    /**
     * Cleanup test environment
     */
    override public function tearDown () : Void
    {
        Tweener.stopAll();

        parent.dispose();
        toHide.dispose();
        toShow.dispose();
    }


    /**
     * Creates transition instance
     */
    private function createTransition () : Transition
    {
        return new Transition();
    }


    @test
    public function change_always_changesViewsCorrectly () : Void
    {
        var onCompleteCalled = false;
        var transition = createTransition();
        transition.change(toHide, toShow, function() onCompleteCalled = true);

        var cnt = 1000;
        while (transition.happening && cnt-- > 0) {
            advanceTime();
            Tweener.update();
        }

        assert.isTrue(toShow.visible);
        assert.isFalse(toHide.visible);
        assert.isTrue(onCompleteCalled);
    }


    @test
    public function reverse_always_changesViewsCorrectly () : Void
    {
        var onCompleteCalled = false;
        var transition = createTransition();
        transition.reverse(toHide, toShow, function() onCompleteCalled = true);

        var cnt = 1000;
        while (transition.happening && cnt-- > 0) {
            advanceTime();
            Tweener.update();
        }

        assert.isTrue(toShow.visible);
        assert.isFalse(toHide.visible);
        assert.isTrue(onCompleteCalled);
    }

}//class TransitionTest