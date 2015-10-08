package sx.skins;

import hunit.TestCase;
import sx.skins.Skin;
import sx.widgets.Widget;
import sx.backend.Backend;



/**
 * sx.skins.Skin
 *
 */
@:access(sx.skins.Skin.usedBy)
@:access(sx.skins.Skin.removed)
@:access(sx.skins.base.SkinBase.usedBy)
@:access(sx.skins.base.SkinBase.removed)
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
    public function usedBy_assignedToInitializedWidget_invokesRefresh () : Void
    {
        var skin = mock(Skin).create();
        var widget = new Widget();
        widget.initialize();

        expect(skin).refresh().once();

        skin.usedBy(widget);
    }


    @test
    public function widget_resized_callsSkinRefresh () : Void
    {
        var widget = new Widget();
        var skin = mock(Skin).create();
        widget.skin = skin;
        widget.initialize();

        expect(skin).refresh().exactly(2);

        widget.width.px = 100;
        widget.height.px = 200;
    }

}//class SkinTest