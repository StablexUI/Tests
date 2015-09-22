package sx.properties.metric;

import hunit.TestCase;
import sx.properties.metric.Padding;
import sx.properties.metric.Units;



/**
 * sx.properties.metric.Padding
 *
 */
class PaddingTest extends TestCase
{

    @test
    public function dip_set_changeAllComponentsToDipsAndCallOnChangeWithTrueTrueOnce () : Void
    {
        var callCount = 0;
        var onChangeWithTrueTrue = false;
        var padding = new Padding();
        padding.onChange = function (h, v) {
            callCount ++;
            onChangeWithTrueTrue = (h && v);
        }

        padding.dip = 10;

        assert.equal(1, callCount);
        assert.isTrue(onChangeWithTrueTrue);
        assert.equal(Dip, padding.left.units);
        assert.equal(Dip, padding.right.units);
        assert.equal(Dip, padding.top.units);
        assert.equal(Dip, padding.bottom.units);
        assert.equal(10., padding.left.dip);
        assert.equal(10., padding.right.dip);
        assert.equal(10., padding.top.dip);
        assert.equal(10., padding.bottom.dip);
    }


    @test
    public function px_set_changeAllComponentsToDipsAndCallOnChangeWithTrueTrueOnce () : Void
    {
        var callCount = 0;
        var onChangeWithTrueTrue = false;
        var padding = new Padding();
        padding.onChange = function (h, v) {
            callCount ++;
            onChangeWithTrueTrue = (h && v);
        }

        padding.px = 10;

        assert.equal(1, callCount);
        assert.isTrue(onChangeWithTrueTrue);
        assert.equal(Pixel, padding.left.units);
        assert.equal(Pixel, padding.right.units);
        assert.equal(Pixel, padding.top.units);
        assert.equal(Pixel, padding.bottom.units);
        assert.equal(10., padding.left.px);
        assert.equal(10., padding.right.px);
        assert.equal(10., padding.top.px);
        assert.equal(10., padding.bottom.px);
    }


    @test
    public function pct_set_changeAllComponentsToDipsAndCallOnChangeWithTrueTrueOnce () : Void
    {
        var callCount = 0;
        var onChangeWithTrueTrue = false;
        var padding = new Padding();
        padding.onChange = function (h, v) {
            callCount ++;
            onChangeWithTrueTrue = (h && v);
        }

        padding.pct = 10;

        assert.equal(1, callCount);
        assert.isTrue(onChangeWithTrueTrue);
        assert.equal(Percent, padding.left.units);
        assert.equal(Percent, padding.right.units);
        assert.equal(Percent, padding.top.units);
        assert.equal(Percent, padding.bottom.units);
        assert.equal(10., padding.left.pct);
        assert.equal(10., padding.right.pct);
        assert.equal(10., padding.top.pct);
        assert.equal(10., padding.bottom.pct);
    }


}//class PaddingTest