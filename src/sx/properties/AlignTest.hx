package sx.properties;

import sx.TestCase;
import sx.properties.Align;


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
        align.onChange.add(function (h, v) {
            callCount ++;
            bothChanged = (v && h);
        });

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
        align.onChange.add(function (h, v) {
            callCount ++;
            calledWithTrueFalse = (h && !v);
        });

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
        align.onChange.add(function (h, v) {
            callCount ++;
            calledWithFalseTrue = (!h && v);
        });

        align.vertical = Top;

        assert.equal(1, callCount);
        assert.isTrue(calledWithFalseTrue);
    }

}//class AlignTest