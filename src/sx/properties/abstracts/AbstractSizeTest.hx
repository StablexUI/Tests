package sx.properties.abstracts;

import hunit.TestCase;
import sx.properties.abstracts.AbstractSize;
import sx.properties.metric.Size;



/**
 * sx.properties.AbstractSize
 *
 */
class AbstractSizeTest extends TestCase
{

    @test
    public function instantiate_fromNumber_createsWeakInstance () : Void
    {
        var size : AbstractSize = 50;

        assert.isTrue((size:Size).weak);
    }


    @test
    public function plus () : Void
    {
        var size : AbstractSize = 50;

        var result = 10 + size;
        assert.equal(60., result);

        var result = size + 10;
        assert.equal(60., result);

        var result = 10. + size + 10 + size + size + 10;
        assert.equal(180., result);
    }


    @test
    public function minus () : Void
    {
        var size : AbstractSize = 50;

        var result = 10 - size;
        assert.equal(-40., result);

        var result = size - 10;
        assert.equal(40., result);

        var result = 10. - size - 10 - size - size - 10;
        assert.equal(-160., result);
    }


    @test
    public function multiply () : Void
    {
        var size : AbstractSize = 5;

        var result = 10 * size;
        assert.equal(50., result);

        var result = size * 10;
        assert.equal(50., result);

        var result = 10. * size * 10 * size * size * 10;
        assert.equal(125000., result);
    }


    @test
    public function divide () : Void
    {
        var size : AbstractSize = 10;

        var result = 10 / size;
        assert.equal(1., result);

        var result = size / 10;
        assert.equal(1., result);

        var result = 10. / size / 10 / size / size / 10;
        assert.equal(0.0001, result);
    }

}//class AbstractSizeTest