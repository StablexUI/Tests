package sx.properties.abstracts;

import hunit.TestCase;
import sx.properties.abstracts.ASize;
import sx.properties.metric.Size;



/**
 * sx.properties.ASize
 *
 */
class ASizeTest extends TestCase
{

    @test
    public function instantiate_fromNumber_createsWeakInstance () : Void
    {
        var size : ASize = 50;

        assert.isTrue((size:Size).weak);
    }


    @test
    public function plus () : Void
    {
        var size : ASize = 50;

        var result = 10 + size;
        assert.equal(60., result);

        var result = size + 10;
        assert.equal(60., result);

        var result = 10. + size + 10 + size + size + 10;
        assert.equal(180., result);

        size += 10;
        assert.equal(60., size);

        size ++;
        assert.equal(61., size);
    }


    @test
    public function minus () : Void
    {
        var size : ASize = 50;

        var result = 10 - size;
        assert.equal(-40., result);

        var result = size - 10;
        assert.equal(40., result);

        var result = 10. - size - 10 - size - size - 10;
        assert.equal(-160., result);

        size -= 10;
        assert.equal(40., size);

        size --;
        assert.equal(39., size);
    }


    @test
    public function multiply () : Void
    {
        var size : ASize = 5;

        var result = 10 * size;
        assert.equal(50., result);

        var result = size * 10;
        assert.equal(50., result);

        var result = 10. * size * 10 * size * size * 10;
        assert.equal(125000., result);

        size *= 2;
        assert.equal(10., size);
    }


    @test
    public function divide () : Void
    {
        var size : ASize = 10;

        var result = 10 / size;
        assert.equal(1., result);

        var result = size / 10;
        assert.equal(1., result);

        var result = 10. / size / 10 / size / size / 10;
        assert.equal(0.0001, result);

        size /= 2;
        assert.equal(5., size);
    }

}//class ASizeTest