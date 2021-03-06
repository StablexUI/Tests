package sx.properties.metric;

import sx.TestCase;
import sx.properties.Orientation;
import sx.properties.metric.Units;
import sx.properties.metric.Size;



/**
 * sx.properties.Size
 *
 */
class SizeTest extends TestCase
{

    @test
    public function isVertical_vertical_returnsTrue () : Void
    {
        var size = new Size(Vertical);

        var isVertical = size.isVertical();

        assert.isTrue(isVertical);
    }


    @test
    public function isVertical_nonVertical_returnsFalse () : Void
    {
        var size = new Size(Horizontal);

        var isVertical = size.isVertical();

        assert.isFalse(isVertical);
    }


    @test
    public function isHorizontal_horizontal_returnsTrue () : Void
    {
        var size = new Size(Horizontal);

        var isHorizontal = size.isHorizontal();

        assert.isTrue(isHorizontal);
    }


    @test
    public function isHorizontal_nonHorizontal_returnsFalse () : Void
    {
        var size = new Size(Vertical);

        var isHorizontal = size.isHorizontal();

        assert.isFalse(isHorizontal);
    }


    @test
    public function onChange_anySetter_alwaysInvokesOnChange () : Void
    {
        var size = new Size();
        var callCounter = 0;
        size.onChange.add(function(p,u,v) callCounter++);

        size.px  = 1;
        size.dip = 1;
        size.pct = 1;

        assert.equal(3, callCounter);
    }


    @test
    public function px_unitsArePixels_returnsStoredValue () : Void
    {
        var size = new Size();
        size.px  = 10;

        assert.equal(10., size.px);
    }


    @test
    public function px_unitsAreDips_convertsCorrectly () : Void
    {
        Sx.dipFactor = 2;

        var size = new Size();
        size.dip = 10;

        assert.equal(20., size.px);
    }


    @test
    public function px_unitsArePercents_convertsCorrectly () : Void
    {
        var pctSource = new Size();
        pctSource.px  = 10;

        var size = new Size();
        size.pctSource = function() return pctSource;
        size.pct = 30;

        assert.equal(3., size.px);
    }


    @test
    public function dip_unitsArePixels_convertsCorrectly () : Void
    {
        Sx.dipFactor = 2;

        var size = new Size();
        size.px  = 10;

        assert.equal(5., size.dip);
    }


    @test
    public function dip_unitsAreDips_returnsStoredValue () : Void
    {
        var size = new Size();
        size.dip = 10;

        assert.equal(10., size.dip);
    }


    @test
    public function dip_unitsArePercents_convertsCorrectly () : Void
    {
        var pctSource = new Size();
        pctSource.dip  = 10;

        var size = new Size();
        size.pctSource = function() return pctSource;
        size.pct = 30;

        assert.equal(3., size.dip);
    }


    @test
    public function pct_unitsArePixels_convertsCorrectly () : Void
    {
        var pctSource = new Size();
        pctSource.px  = 10;

        var size = new Size();
        size.pctSource = function() return pctSource;
        size.px = 3;

        assert.equal(30., size.pct);
    }


    @test
    public function pct_unitsAreDips_convertsCorrectly () : Void
    {
        var pctSource = new Size();
        pctSource.dip  = 10;

        var size = new Size();
        size.pctSource = function() return pctSource;
        size.dip = 3;

        assert.equal(30., size.pct);
    }


    @test
    public function pct_unitsArePercents_returnsStoredValue () : Void
    {
        var size = new Size();
        size.pct = 30;

        assert.equal(30., size.pct);
    }


    @test
    public function dip_set_onChangeWithCorrectArguments () : Void
    {
        var property : Size = null;
        var units = Percent;
        var value = 0.;

        var size = new Size();
        size.px  = 10;
        size.onChange.add(function (p, u, v) {
            property = p;
            units    = u;
            value    = v;
        });

        size.dip = 5;

        assert.equal(size, property);
        assert.equal(Pixel, units);
        assert.equal(10., value);
    }


    @test
    public function px_set_onChangeWithCorrectArguments () : Void
    {
        var property : Size = null;
        var units = Percent;
        var value = 0.;

        var size = new Size();
        size.dip  = 10;
        size.onChange.add(function (p, u, v) {
            property = p;
            units    = u;
            value    = v;
        });

        size.px = 5;

        assert.equal(size, property);
        assert.equal(Dip, units);
        assert.equal(10., value);
    }


    @test
    public function pct_set_onChangeWithCorrectArguments () : Void
    {
        var property : Size = null;
        var units = Dip;
        var value = 0.;

        var size = new Size();
        size.px  = 10;
        size.onChange.add(function (p, u, v) {
            property = p;
            units    = u;
            value    = v;
        });

        size.pct = 5;

        assert.equal(size, property);
        assert.equal(Pixel, units);
        assert.equal(10., value);
    }


    @test
    public function pct_setLessThanMin_minValueAssigned () : Void
    {
        var size = new Size();
        size.min.pct = 10;

        size.pct = 0;

        assert.equal(10., size.pct);
    }


    @test
    public function dip_setLessThanMin_minValueAssigned () : Void
    {
        var size = new Size();
        size.min.dip = 10;

        size.dip = 0;

        assert.equal(10., size.dip);
    }


    @test
    public function px_setLessThanMin_minValueAssigned () : Void
    {
        var size = new Size();
        size.min.px = 10;

        size.px = 0;

        assert.equal(10., size.px);
    }


    @test
    public function min_changedSoThatSizeViolatesConstraint_valueAdjusted () : Void
    {
        var dispatched = false;
        var size = new Size();
        size.dip = 0;
        size.onChange.add(function(s,u,v) dispatched = true);

        size.min.dip = 10;

        assert.isTrue(dispatched);
        assert.equal(10., size.dip);
    }


    @test
    public function pct_setGreaterThanMax_maxValueAssigned () : Void
    {
        var size = new Size();
        size.max.pct = 10;

        size.pct = 100;

        assert.equal(10., size.pct);
    }


    @test
    public function dip_setGreaterThanMax_maxValueAssigned () : Void
    {
        var size = new Size();
        size.max.dip = 10;

        size.dip = 100;

        assert.equal(10., size.dip);
    }


    @test
    public function px_setGreaterThanMax_maxValueAssigned () : Void
    {
        var size = new Size();
        size.max.px = 10;

        size.px = 100;

        assert.equal(10., size.px);
    }


    @test
    public function max_changedSoThatSizeViolatesConstraint_valueAdjusted () : Void
    {
        var dispatched = false;
        var size = new Size();
        size.dip = 100;
        size.onChange.add(function(s,u,v) dispatched = true);

        size.max.dip = 10;

        assert.isTrue(dispatched);
        assert.equal(10., size.dip);
    }

}//class SizeTest