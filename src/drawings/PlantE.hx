package drawings;
import lsystem.*;
@:forward
abstract PlantE( Drawing ) from Drawing to Drawing {
    public inline function new( pos, lineFunc ){
        var options = { axiom : 'X' };
        var lsystem = new LSystem(options);
        lsystem.setRule( "X", "F[+X][-X]FX" );
        lsystem.setRule( "F", "FF" );
        lsystem.iterate(7);
        var angle = 270.0;
        var line = lineFunc;
        this = new Drawing( lsystem, pos, angle );
        this.render = function( charCode: Int ): Void {
            var s = this.stack;
            switch( charCode ){
                case '['.code:
                    s.pushSame();
                case ']'.code:
                    s.pop();
                case '+'.code:
                    s.rotate(27.5);
                case '-'.code:
                    s.rotate(-27.5);
                case 'X'.code,'F'.code:
                    line( cast s.forwardDraw(1) );
            }
        }
    }
}