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
    public function set_all_changeAllComponentsToDipsAndCallOnChangeWithTrueTrueOnce () : Void
    {
        var callCount = 0;
        var onChangeWithTrueTrue = false;
        var padding = new Padding();
        padding.onComponentsChange.add(function (h, v) {
            callCount ++;
            onChangeWithTrueTrue = (h && v);
        });

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
    public function horizontal_set_changeLeftAndRightAndCallOnChangeWithTrueFalseOnce () : Void
    {
        var callCount = 0;
        var onChangeWithTrueFalse = false;
        var padding = new Padding();
        padding.onComponentsChange.add(function (h, v) {
            callCount ++;
            onChangeWithTrueFalse = (h && !v);
        });

        padding.horizontal.pct = 10;

        assert.equal(1, callCount);
        assert.isTrue(onChangeWithTrueFalse);
        assert.equal(Percent, padding.left.units);
        assert.equal(Percent, padding.right.units);
        assert.equal(10., padding.left.pct);
        assert.equal(10., padding.right.pct);
    }


    @test
    public function vertical_set_changeLeftAndRightAndCallOnChangeWithFalseTrueOnce () : Void
    {
        var callCount = 0;
        var onChangeWithFalseTrue = false;
        var padding = new Padding();
        padding.onComponentsChange.add(function (h, v) {
            callCount ++;
            onChangeWithFalseTrue = (!h && v);
        });

        padding.vertical.pct = 10;

        assert.equal(1, callCount);
        assert.isTrue(onChangeWithFalseTrue);
        assert.equal(Percent, padding.top.units);
        assert.equal(Percent, padding.bottom.units);
        assert.equal(10., padding.top.pct);
        assert.equal(10., padding.bottom.pct);
    }

}//class PaddingTest