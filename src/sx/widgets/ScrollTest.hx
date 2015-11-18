package sx.widgets;

import hunit.TestCase;
import sx.widgets.Scroll;



/**
 * sx.widgets.Scroll
 *
 */
class ScrollTest extends TestCase
{

    @test
    public function getMaxScrollX_scrolledContentIsWiderThanScrollWidget_returnsCorrectValue () : Void
    {
        var scroll = new Scroll();
        scroll.width.dip = 100;
        var content = scroll.addChild(new Widget());
        content.left.dip  = -50;
        content.width.dip = 500;

        var max = scroll.getMaxScrollX();

        assert.equal(400., max);
    }


    @test
    public function getMaxScrollY_scrolledContentIsWiderThanScrollWidget_returnsCorrectValue () : Void
    {
        var scroll = new Scroll();
        scroll.height.dip = 100;
        var content = scroll.addChild(new Widget());
        content.top.dip    = -50;
        content.height.dip = 500;

        var max = scroll.getMaxScrollY();

        assert.equal(400., max);
    }


    @test
    public function scrollX_always_calculatedCorreclty () : Void
    {
        var scroll = new Scroll();
        var content = scroll.addChild(new Widget());

        content.left.dip = -500;

        assert.equal(500., scroll.scrollX);
    }


    @test
    public function scrollY_always_calculatedCorreclty () : Void
    {
        var scroll = new Scroll();
        var content = scroll.addChild(new Widget());

        content.top.dip = -500;

        assert.equal(500., scroll.scrollY);
    }


    @test
    public function scrollBy_byXWhileAlmostAtMaxScrollX_scrolledCorrectly () : Void
    {
        var scroll = new Scroll();
        scroll.width.dip = 400;
        var content = scroll.addChild(new Widget());
        content.width.dip = 1000;
        content.left.dip = -500;

        scroll.scrollBy(200, 0);

        assert.equal(-600., content.left.dip);
    }

}//class ScrollTest