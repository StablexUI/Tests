package sx.skins;

import hunit.TestCase;
import sx.skins.PaintSkin;



/**
 * sx.skins.PaintSkin
 *
 */
class PaintSkinTest extends TestCase
{

    @test
    public function color_changed_invokesOnChange () : Void
    {
        var onChangeCalled = false;
        var skin = new PaintSkin();
        skin.onChange = function () onChangeCalled = true;

        skin.color = 0xFF0000;

        assert.isTrue(onChangeCalled);
    }

}//class PaintSkinTest