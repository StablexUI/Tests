package sx.skins;

import hunit.TestCase;
import sx.skins.Skin;
import sx.widgets.Widget;
import sx.backend.Backend;



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


    @test
    public function usedBy_always_invokesRefresh () : Void
    {
        var skin = mock(Skin).create();

        expect(skin).refresh().once();

        skin.usedBy(new Widget());
    }


}//class SkinTest