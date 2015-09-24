package sx.widgets;

import hunit.TestCase;
import sx.backend.TextRenderer;
import sx.widgets.Text;



/**
 * sx.widgets.Text
 *
 */
class TextTest extends TestCase
{

    @test
    public function text_changed_invokesRendererSetText () : Void
    {
        var text = 'hello';
        var textField = mock(Text).create();
        var renderer = mock(TextRenderer).create(textField);
        modify(textField).renderer = renderer;

        expect(renderer).setText(text).once();

        textField.text = text;
    }


    @test
    public function setTextFormat_always_invokesRendererSetFormat () : Void
    {
        var textField = mock(Text).create();
        var renderer = mock(TextRenderer).create(textField);
        modify(textField).renderer = renderer;
        var format = textField.getTextFormat();

        expect(renderer).setFormat(format).once();

        textField.setTextFormat(format);
    }

}//class TextTest