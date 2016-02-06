package sx.widgets.base;

import sx.layout.Layout;
import sx.TestCase;


/**
 * sx.widgets.base.Box
 *
 */
class BoxTest extends TestCase
{

    @test
    public function layout_setNonLineLayout_throwsException () : Void
    {
        var box = new Box();

        expectException(match.type(sx.exceptions.InvalidArgumentException));

        box.layout = new Layout();
    }


    @test
    public function layout_onDisposeSetNull_doesNotThrowException () : Void
    {
        var box = new Box();

        box.dispose();

        assert.isNull(box.layout);
    }

}//class BoxTest