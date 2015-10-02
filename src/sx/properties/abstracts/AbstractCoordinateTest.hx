package sx.properties.abstracts;

import hunit.TestCase;
import sx.properties.abstracts.AbstractCoordinate;
import sx.properties.metric.Coordinate;



/**
 * sx.properties.AbstractCoordinate
 *
 */
class AbstractCoordinateTest extends TestCase
{

    @test
    public function instantiate_fromNumber_createsWeakInstance () : Void
    {
        var coord : AbstractCoordinate = 50;

        assert.isTrue((coord:Coordinate).weak);
    }


    @test
    public function plus () : Void
    {
        var coord : AbstractCoordinate = 50;

        var result = 10 + coord;
        assert.equal(60., result);

        var result = coord + 10;
        assert.equal(60., result);

        var result = 10. + coord + 10 + coord + coord + 10;
        assert.equal(180., result);

        coord += 10;
        assert.equal(60., coord);

        coord ++;
        assert.equal(61., coord);
    }


    @test
    public function minus () : Void
    {
        var coord : AbstractCoordinate = 50;

        var result = 10 - coord;
        assert.equal(-40., result);

        var result = coord - 10;
        assert.equal(40., result);

        var result = 10. - coord - 10 - coord - coord - 10;
        assert.equal(-160., result);

        coord -= 10;
        assert.equal(40., coord);

        coord --;
        assert.equal(39., coord);
    }


    @test
    public function multiply () : Void
    {
        var coord : AbstractCoordinate = 5;

        var result = 10 * coord;
        assert.equal(50., result);

        var result = coord * 10;
        assert.equal(50., result);

        var result = 10. * coord * 10 * coord * coord * 10;
        assert.equal(125000., result);

        coord *= 2;
        assert.equal(10., coord);
    }


    @test
    public function divide () : Void
    {
        var coord : AbstractCoordinate = 10;

        var result = 10 / coord;
        assert.equal(1., result);

        var result = coord / 10;
        assert.equal(1., result);

        var result = 10. / coord / 10 / coord / coord / 10;
        assert.equal(0.0001, result);

        coord /= 2;
        assert.equal(5., coord);
    }

}//class AbstractCoordinateTest