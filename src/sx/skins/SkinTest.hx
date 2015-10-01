package sx.skins;

import hunit.TestCase;
import sx.skins.Skin;
import sx.widgets.Widget;



/**
 * sx.skins.Skin
 *
 */
class SkinTest extends TestCase
{

    @test
    public function usedBy_skinAlreadyUsedByAnotherWidget_skinRemovedFromAnotherWidget () : Void
    {
        var widget = new Widget();
        var skin   = new Skin();
        widget.skin = skin;

        skin.usedBy(new Widget());

        assert.isNull(widget.skin);
    }

}//class SkinTest