package sx.tween;

import hunit.TestCase;
import sx.tween.Tweener;



/**
 * sx.tween.Tweener
 *
 */
@group('tween')
class TweenerTest extends TestCase
{

    /** Default `Tweener.getTime` implementation */
    private var defaultGetTime : Void->Float;
    /** Time counter for test implementation of `Tweener.getTime` */
    private var time : Int = 0;


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
     * Setup test environment
     */
    override public function setup () : Void
    {

    }


    /**
     * Cleanup test environment
     */
    override public function tearDown () : Void
    {
        Tweener.resumeAll();
        Tweener.stopAll();
    }


    /**
     * Simulate time flow
     */
    private inline function advanceTime () : Void
    {
        time ++;
    }


    @test
    public function tween_onTweenerUpdate_updatesTweens () : Void
    {
        var updated = false;
        var tweener = new Tweener();
        var value = 0.5;
        tweener.tween(10, value = 10).onUpdate(function() updated = true);

        this.advanceTime();
        Tweener.update();

        assert.isTrue(updated);
    }


    @test
    public function tween_onTweenerUpdate_doesNotUpdateFinishedTweens () : Void
    {
        var updated = 0;
        var tweener = new Tweener();
        var value = 0.5;
        tweener.tween(5, value = 10).onUpdate(function() updated++);

        for (i in 0...10) {
            this.advanceTime();
            Tweener.update();
        }

        assert.equal(5, updated);
    }


    @test
    public function puaseAll_always_blocksUpdatingTweensOnTweenerUpdate () : Void
    {
        var updated = false;
        var tweener = new Tweener();
        var value = 0.5;
        tweener.tween(5, value = 10).onUpdate(function() updated = true);

        Tweener.pauseAll();
        for (i in 0...10) {
            this.advanceTime();
            Tweener.update();
        }

        assert.isFalse(updated);
    }


    @test
    public function resumeAll_always_correctlyUpdatesTweensExpetedAmountTimes () : Void
    {
        var updated = 0;
        var tweener = new Tweener();
        var value = 0.5;

        var a = tweener.tween(5, value = 10).onUpdate(function() updated++);

        for (i in 0...10) {
            this.advanceTime();
            if (i == 3) Tweener.pauseAll();

            if (i == 6) Tweener.resumeAll();

            Tweener.update();
        }

        assert.equal(5, updated);
    }

}//class TweenerTest