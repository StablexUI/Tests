package sx.properties.metric;

import hunit.TestCase;
import sx.properties.metric.Size;
import sx.Sx;



/**
 * sx.properties.Origin
 *
 */
class OriginTest extends TestCase
{
    /**
     * Provides `Size` instances for tests
     */
    static private function dummySize (px:Float) : Size
    {
        var dummy = new Size() ;
        dummy.px = px;

        return dummy;
    }


    @test
    public function constructor_correctlyPairsProperties () : Void
    {
        var width = new Size();
        var height = new Size();

        var origin = new Origin(
            function() return width,
            function() return height
        );

        assert.equal(origin.right, (origin.left:Coordinate).pair());
        assert.isNull((origin.left:Coordinate).ownerSize);
        assert.equal(width, (origin.left:Coordinate).pctSource());
        assert.isTrue(origin.left.selected);

        assert.equal(origin.left, (origin.right:Coordinate).pair());
        assert.isNull((origin.right:Coordinate).ownerSize);
        assert.equal(width, (origin.right:Coordinate).pctSource());
        assert.isFalse(origin.right.selected);

        assert.equal(origin.bottom, (origin.top:Coordinate).pair());
        assert.isNull((origin.top:Coordinate).ownerSize);
        assert.equal(height, (origin.top:Coordinate).pctSource());
        assert.isTrue(origin.top.selected);

        assert.equal(origin.top, (origin.bottom:Coordinate).pair());
        assert.isNull((origin.bottom:Coordinate).ownerSize);
        assert.equal(height, (origin.bottom:Coordinate).pctSource());
        assert.isFalse(origin.bottom.selected);
    }


    @test
    public function set_valuesBetween0And1_treatedAsPercent () : Void
    {
        var origin = new Origin(
            function() return dummySize(100),
            function() return dummySize(30)
        );

        origin.set(0.5, 0.5);

        assert.equal(50., origin.left.px);
        assert.equal(15., origin.top.px);
    }


    @test
    public function set_valuesLessThan0OrGreaterThan1_treatedAsDips () : Void
    {
        Sx.dipFactor = 2;
        var origin = new Origin(
            function() return dummySize(0),
            function() return dummySize(0)
        );

        origin.set(-20, 10);

        assert.equal(-40., origin.left.px);
        assert.equal(20., origin.top.px);
    }

}//class OriginTest