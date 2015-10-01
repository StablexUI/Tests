package sx.properties;

import hunit.TestCase;
import sx.properties.AutoSizeBit;



/**
 * sx.properties.AutoSizeBit
 *
 */
class AutoSizeBitTest extends TestCase
{

    @test
    public function set_true_Both () : Void
    {
        var autoSize : AutoSizeBit = true;

        assert.equal(Both, autoSize);
        assert.isTrue(autoSize.width);
        assert.isTrue(autoSize.height);
    }


    @test
    public function set_false_None () : Void
    {
        var autoSize : AutoSizeBit = false;

        assert.equal(None, autoSize);
        assert.isFalse(autoSize.width);
        assert.isFalse(autoSize.height);
    }


    @test
    public function width_setTrue_isTrue () : Void
    {
        var autoSize = None;

        autoSize.width = true;

        assert.equal(Width, autoSize);
        assert.isTrue(autoSize.width);
    }


    @test
    public function width_setFalse_isFalse () : Void
    {
        var autoSize = Both;

        autoSize.width = false;

        assert.equal(Height, autoSize);
        assert.isFalse(autoSize.width);
    }


    @test
    public function height_setTrue_isTrue () : Void
    {
        var autoSize = None;

        autoSize.height = true;

        assert.equal(Height, autoSize);
        assert.isTrue(autoSize.height);
    }


    @test
    public function height_setFalse_isFalse () : Void
    {
        var autoSize = Both;

        autoSize.height = false;

        assert.equal(Width, autoSize);
        assert.isFalse(autoSize.height);
    }


    @test
    public function neither () : Void
    {
        var autoSize = None;
        assert.isTrue(autoSize.neither());

        var autoSize = Both;
        assert.isFalse(autoSize.neither());

        var autoSize = Width;
        assert.isFalse(autoSize.neither());

        var autoSize = Height;
        assert.isFalse(autoSize.neither());
    }


    @test
    public function either () : Void
    {
        var autoSize = None;
        assert.isFalse(autoSize.either());

        var autoSize = Both;
        assert.isTrue(autoSize.either());

        var autoSize = Width;
        assert.isTrue(autoSize.either());

        var autoSize = Height;
        assert.isTrue(autoSize.either());
    }


    @test
    public function both () : Void
    {
        var autoSize = None;
        assert.isFalse(autoSize.both());

        var autoSize = Both;
        assert.isTrue(autoSize.both());

        var autoSize = Width;
        assert.isFalse(autoSize.both());

        var autoSize = Height;
        assert.isFalse(autoSize.both());
    }

}//class AutoSizeBitTest