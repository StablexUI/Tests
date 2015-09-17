package sx.properties;

import hunit.TestCase;
import sx.properties.Size;
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

        assert.equal(origin.right, origin.left.pair());
        assert.isNull(origin.left.ownerSize);
        assert.equal(width, origin.left.pctSource());
        assert.isTrue(origin.left.selected);

        assert.equal(origin.left, origin.right.pair());
        assert.isNull(origin.right.ownerSize);
        assert.equal(width, origin.right.pctSource());
        assert.isFalse(origin.right.selected);

        assert.equal(origin.bottom, origin.top.pair());
        assert.isNull(origin.top.ownerSize);
        assert.equal(height, origin.top.pctSource());
        assert.isTrue(origin.top.selected);

        assert.equal(origin.top, origin.bottom.pair());
        assert.isNull(origin.bottom.ownerSize);
        assert.equal(height, origin.bottom.pctSource());
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