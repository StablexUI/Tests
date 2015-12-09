package sx.properties.metric;

import sx.TestCase;
import sx.properties.metric.Offset;
import sx.properties.metric.Size;
import sx.Sx;



/**
 * sx.properties.metric.Offset
 *
 */
class OffsetTest extends TestCase
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

        var offset = new Offset(
            function() return width,
            function() return height
        );

        assert.equal(offset.right, (offset.left:Coordinate).pair());
        assert.equal(width, (offset.left:Coordinate).ownerSize());
        assert.equal(width, (offset.left:Coordinate).pctSource());
        assert.isTrue(offset.left.selected);

        assert.equal(offset.left, (offset.right:Coordinate).pair());
        assert.equal(width, (offset.right:Coordinate).ownerSize());
        assert.equal(width, (offset.right:Coordinate).pctSource());
        assert.isFalse(offset.right.selected);

        assert.equal(offset.bottom, (offset.top:Coordinate).pair());
        assert.equal(height, (offset.top:Coordinate).ownerSize());
        assert.equal(height, (offset.top:Coordinate).pctSource());
        assert.isTrue(offset.top.selected);

        assert.equal(offset.top, (offset.bottom:Coordinate).pair());
        assert.equal(height, (offset.bottom:Coordinate).ownerSize());
        assert.equal(height, (offset.bottom:Coordinate).pctSource());
        assert.isFalse(offset.bottom.selected);
    }


    @test
    public function set_valuesBetween0And1_treatedAsPercent () : Void
    {
        var offset = new Offset(
            function() return dummySize(100),
            function() return dummySize(30)
        );

        offset.set(0.5, 0.5);

        assert.equal(50., offset.left.px);
        assert.equal(15., offset.top.px);
    }


    @test
    public function set_valuesLessThan0OrGreaterThan1_treatedAsDips () : Void
    {
        Sx.dipFactor = 2;
        var offset = new Offset(
            function() return dummySize(0),
            function() return dummySize(0)
        );

        offset.set(-20, 10);

        assert.equal(-40., offset.left.px);
        assert.equal(20., offset.top.px);
    }

}//class OffsetTest