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
    public function set_always_invokesOnChange () : Void
    {
        var onChangeInvoked = false;
        var autoSize = new AutoSize(false);
        autoSize.onChange = function () onChangeInvoked = true;

        autoSize.set(false);

        assert.isTrue(onChangeInvoked);
    }


    @test
    public function width_changed_invokesOnChange () : Void
    {
        var onChangeInvoked = false;
        var autoSize = new AutoSize();
        autoSize.onChange = function () onChangeInvoked = true;

        autoSize.width = true;

        assert.isTrue(onChangeInvoked);
    }


    @test
    public function height_changed_invokesOnChange () : Void
    {
        var onChangeInvoked = false;
        var autoSize = new AutoSize();
        autoSize.onChange = function () onChangeInvoked = true;

        autoSize.height = true;

        assert.isTrue(onChangeInvoked);
    }

}//class AutoSizeTest