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
    public function skin_usedBy_invokesWidgetBackendWidgetSkinChanged () : Void
    {
        var widget = mock(Widget).create();
        var backend = mock(Backend).create(widget);
        modify(widget).backend = backend;

        expect(backend).widgetSkinChanged().once();

        widget.skin = new Skin();
    }


    @test
    public function skin_removed_invokesWidgetBackendWidgetSkinChanged () : Void
    {
        var widget = mock(Widget).create();
        var backend = mock(Backend).create(widget);
        modify(widget).backend = backend;
        widget.skin = new Skin();

        expect(backend).widgetSkinChanged().once();

        widget.skin = null;
    }


}//class SkinTest