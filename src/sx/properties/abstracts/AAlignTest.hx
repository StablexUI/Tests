package sx.properties.abstracts;

import sx.TestCase;
import sx.properties.abstracts.AAlign;
import sx.properties.Align;



/**
 * sx.properties.abstracts.AAlign
 *
 */
class AAlignTest extends TestCase
{

    @test
    public function fromNone_always_bothVerticalHorizontalBecomesNone () : Void
    {
        var align : AAlign = None;

        assert.equal(VNone, align.vertical);
        assert.equal(HNone, align.horizontal);
    }


}//class AAlignTest