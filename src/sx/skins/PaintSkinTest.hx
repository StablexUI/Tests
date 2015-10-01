package sx.skins;

import hunit.TestCase;
import sx.skins.PaintSkin;
import sx.widgets.Widget;
import sx.backend.Backend;


/**
 * sx.skins.PaintSkin
 *
 */
class PaintSkinTest extends TestCase
{

    @test
    public function color_changed_widgetBackendNotified () : Void
    {
        var widget  = mock(Widget).create();
        var backend = mock(Backend).create(widget);
        modify(widget).backend = backend;
        var skin = new PaintSkin();
        widget.skin = skin;

        expect(backend).widgetSkinChanged().once();

        skin.color = 0xFF0000;
    }


    @test
    public function alpha_changed_widgetBackendNotified () : Void
    {
        var widget  = mock(Widget).create();
        var backend = mock(Backend).create(widget);
        modify(widget).backend = backend;
        var skin = new PaintSkin();
        widget.skin = skin;

        expect(backend).widgetSkinChanged().once();

        skin.alpha = 0.5;
    }

}//class PaintSkinTest