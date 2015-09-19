package sx.properties;

import hunit.TestCase;
import sx.properties.AutoSize;



/**
 * sx.properties.AutoSize
 *
 */
class AutoSizeTest extends TestCase
{

    @test
    public function set_false_setWidthAndHeightFalse () : Void
    {
        var autoSize = new AutoSize(true);

        autoSize.set(false);

        assert.isFalse(autoSize.width);
        assert.isFalse(autoSize.height);
    }


    @test
    public function set_true_setWidthAndHeightTrue () : Void
    {
        var autoSize = new AutoSize(false);

        autoSize.set(true);

        assert.isTrue(autoSize.width);
        assert.isTrue(autoSize.height);
    }


    @test
    public function set_always_invokesOnChangeWithTrueTrue () : Void
    {
        var onChangeInvoked = false;
        var autoSize = new AutoSize(false);
        autoSize.onChange = function (w,h) onChangeInvoked = (w && h);

        autoSize.set(false);

        assert.isTrue(onChangeInvoked);
    }


    @test
    public function width_changed_invokesOnChangeWithTrueFalse () : Void
    {
        var onChangeInvoked = false;
        var autoSize = new AutoSize();
        autoSize.onChange = function (w,h) onChangeInvoked = (w && !h);

        autoSize.width = true;

        assert.isTrue(onChangeInvoked);
    }


    @test
    public function height_changed_invokesOnChangeWithFalseTrue () : Void
    {
        var onChangeInvoked = false;
        var autoSize = new AutoSize();
        autoSize.onChange = function (w,h) onChangeInvoked = (!w && h);

        autoSize.height = true;

        assert.isTrue(onChangeInvoked);
    }

}//class AutoSizeTest