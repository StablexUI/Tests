package sx.properties.abstracts;

import sx.TestCase;
import sx.properties.abstracts.ACoordinate;
import sx.properties.metric.Coordinate;



/**
 * sx.properties.ACoordinate
 *
 */
class ACoordinateTest extends TestCase
{

    @test
    public function instantiate_fromNumber_createsWeakInstance () : Void
    {
        var coord : ACoordinate = 50;

        assert.isTrue((coord:Coordinate).weak);
    }


    @test
    public function plus () : Void
    {
        var coord : ACoordinate = 50;

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
        var coord : ACoordinate = 50;

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
        var coord : ACoordinate = 5;

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
        var coord : ACoordinate = 10;

        var result = 10 / coord;
        assert.equal(1., result);

        var result = coord / 10;
        assert.equal(1., result);

        var result = 10. / coord / 10 / coord / coord / 10;
        assert.equal(0.0001, result);

        coord /= 2;
        assert.equal(5., coord);
    }

}//class ACoordinateTest