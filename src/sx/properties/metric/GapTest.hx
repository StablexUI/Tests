package sx.properties.metric;

import hunit.TestCase;
import sx.properties.metric.Gap;
import sx.properties.metric.Units;



/**
 * sx.properties.metric.Gap
 *
 */
class GapTest extends TestCase
{


    @test
    public function set_all_changeAllComponentsToDipsAndCallOnChangeWithTrueTrueOnce () : Void
    {
        var callCount = 0;
        var onChangeWithTrueTrue = false;
        var gap = new Gap();
        gap.onChange.add(function (h, v) {
            callCount ++;
            onChangeWithTrueTrue = (h && v);
        });

        gap.px = 10;

        assert.equal(1, callCount);
        assert.isTrue(onChangeWithTrueTrue);
        assert.equal(Pixel, gap.horizontal.units);
        assert.equal(Pixel, gap.vertical.units);
        assert.equal(10., gap.horizontal.px);
        assert.equal(10., gap.vertical.px);
    }


    @test
    public function horizontal_set_callOnChangeWithTrueFalseOnce () : Void
    {
        var callCount = 0;
        var onChangeWithTrueFalse = false;
        var gap = new Gap();
        gap.onChange.add(function (h, v) {
            callCount ++;
            onChangeWithTrueFalse = (h && !v);
        });

        gap.horizontal.pct = 10;

        assert.equal(1, callCount);
        assert.isTrue(onChangeWithTrueFalse);
        assert.equal(Percent, gap.horizontal.units);
        assert.equal(10., gap.horizontal.pct);
    }


    @test
    public function vertical_set_callOnChangeWithFalseTrueOnce () : Void
    {
        var callCount = 0;
        var onChangeWithFalseTrue = false;
        var gap = new Gap();
        gap.onChange.add(function (h, v) {
            callCount ++;
            onChangeWithFalseTrue = (!h && v);
        });

        gap.vertical.pct = 10;

        assert.equal(1, callCount);
        assert.isTrue(onChangeWithFalseTrue);
        assert.equal(Percent, gap.vertical.units);
        assert.equal(10., gap.vertical.pct);
    }

}//class GapTest