package sx.widgets;

import hunit.TestCase;
import sx.backend.TextInputRenderer;
import sx.widgets.TextInput;



/**
 * sx.widgets.TextInput
 *
 */
class TextInputTest extends TestCase
{

    @test
    public function invitation_setInvitationWhileNoTextInserted_invitationPassedToRenderer () : Void
    {
        var text = 'hello';
        var input = mock(TextInput).create();
        var renderer = mock(TextInputRenderer).create(input);
        modify(input).renderer = renderer;

        expect(renderer).setText(text).once();

        input.invitation = text;
    }


    @test
    public function invitation_widgetReceiveCursor_invitationRemovedFromRenderer () : Void
    {
        var text = 'hello';
        var input = mock(DummyTextInput).create();
        input.invitation = text;
        var renderer : DummyTextInputRenderer = cast input.renderer;

        renderer.receiveCursorTest();

        assert.equal('', renderer.getText());
    }


    @test
    public function invitation_widgetLostCursor_invitationreturnedToRenderer () : Void
    {
        var text = 'hello';
        var input = mock(DummyTextInput).create();
        input.invitation = text;
        var renderer : DummyTextInputRenderer = cast input.renderer;
        renderer.receiveCursorTest();

        renderer.loseCursorTest();

        assert.equal(text, renderer.getText());
    }

}//class TextInputTest



class DummyTextInput extends TextInput
{
    override private function __createRenderer () renderer = new DummyTextInputRenderer(this);
}

class DummyTextInputRenderer extends TextInputRenderer
{
    public var receiveCursorTest : Null<Void->Void>;
    public var loseCursorTest : Null<Void->Void>;
    override public function onReceiveCursor(cb) receiveCursorTest = cb;
    override public function onLoseCursor(cb) loseCursorTest = cb;
}