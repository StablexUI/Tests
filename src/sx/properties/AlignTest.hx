package sx.properties;

import hunit.TestCase;
import sx.properties.Align;
import sx.properties.VerticalAlign;
import sx.properties.HorizontalAlign;



/**
 * sx.properties.Align
 *
 */
class AlignTest extends TestCase
{

    @test
    public function set_always_invokesOnChangeOnceWithTrueTrue () : Void
    {
        var callCount   = 0;
        var bothChanged = false;
        var align       = new Align();
        align.onChange  = function (h, v) {
            callCount ++;
            bothChanged = (v && h);
        }

        align.set(Left, Top);

        assert.equal(1, callCount);
        assert.isTrue(bothChanged);
    }


    @test
    public function horizontal_changed_invokesOnChangeWithTrueFalse () : Void
    {
        var callCount = 0;
        var calledWithTrueFalse = false;
        var align = new Align();
        align.onChange = function (h, v) {
            callCount ++;
            calledWithTrueFalse = (h && !v);
        }

        align.horizontal = Left;

        assert.equal(1, callCount);
        assert.isTrue(calledWithTrueFalse);
    }


    @test
    public function vertical_changed_invokesOnChangeWithFalseTrue () : Void
    {
        var callCount = 0;
        var calledWithFalseTrue = false;
        var align = new Align();
        align.onChange = function (h, v) {
            callCount ++;
            calledWithFalseTrue = (!h && v);
        }

        align.vertical = Top;

        assert.equal(1, callCount);
        assert.isTrue(calledWithFalseTrue);
    }

}//class AlignTest