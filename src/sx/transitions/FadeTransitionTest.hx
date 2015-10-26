package sx.transitions;

import sx.transitions.FadeTransition;
import sx.transitions.Transition;
import sx.transitions.TransitionTest;


/**
 * sx.transitions.FadeTransition
 *
 */
@inheritTests
class FadeTransitionTest extends TransitionTest
{

    /**
     * Instantiate FadeTransition
     */
    override private function createTransition () : Transition
    {
        return new FadeTransition();
    }

}//class FadeTransitionTest