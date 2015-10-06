package sx.widgets;

import hunit.TestCase;
import sx.layout.LineLayout;
import sx.widgets.Button;
import sx.widgets.Text;



/**
 * sx.widgets.Button
 *
 */
class ButtonTest extends TestCase
{

    @test
    public function ico_assignIcon_iconAddedToDisplayList () : Void
    {
        var button = new Button();
        var ico = new Widget();

        button.ico = ico;

        assert.equal((button:Widget), ico.parent);
    }


    @test
    public function ico_assignNewIcon_oldIconRemovedFromDisplayList () : Void
    {
        var button = new Button();
        var oldIco = new Widget();
        button.ico = oldIco;

        button.ico = new Widget();

        assert.isNull(oldIco.parent);
    }


    @test
    public function hasLabel_noLabelOrTextAssigned_returnsFalse () : Void
    {
        var button = new Button();

        var hasLabel = button.hasLabel();

        assert.isFalse(hasLabel);
    }


    @test
    public function hasLabel_textAssigned_returnsTrue () : Void
    {
        var button = new Button();
        button.text = 'Hello';

        var hasLabel = button.hasLabel();

        assert.isTrue(hasLabel);
    }


    @test
    public function label_assignLabel_labelAddedToDisplayList () : Void
    {
        var button = new Button();
        var label = new Text();

        button.label = label;

        assert.equal((button:Widget), label.parent);
    }


    @test
    public function label_assignNewLabel_oldLabelRemovedFromDisplayList () : Void
    {
        var button = new Button();
        var oldLabel = new Text();
        button.label = oldLabel;

        button.label = new Text();

        assert.isNull(oldLabel.parent);
    }


    @test
    public function label_accessLabel_automaticallyCreatesDefaultTextWidget () : Void
    {
        var button = new Button();

        button.label.padding = 10;

        assert.isTrue(button.hasLabel());
        assert.equal((button:Widget), button.label.parent);
    }


    @test
    public function layout_notAddedDisplayListYet_layoutIsNotCreated () : Void
    {
        var button = new Button();
        var child1 = button.addChild(new Widget());
        var child2 = button.addChild(new Widget());

        child1.width = 30;
        child2.width = 20;

        assert.equal(0.0, child1.left);
        assert.equal(0.0, child1.top);
        assert.equal(0.0, child2.left);
        assert.equal(0.0, child2.top);
    }


    @test
    public function layout_buttonAddedToDisplayListWithoutUserDefinedLayout_createsDefaultLayout () : Void
    {
        var button = new Button();

        new Widget().addChild(button);

        assert.type(LineLayout, button.layout);
    }

}//class ButtonTest