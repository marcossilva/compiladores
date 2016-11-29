package lua;

import java.io.File;
import java.io.FileReader;
import java.util.logging.Level;
import java.util.logging.Logger;
import java_cup.runtime.Symbol;

/**
 *
 * @author marcos
 */
public class Main {
    public static void main(String[] args){
        geraLex();
        testaLex();
//        geraParser();
//        testaParser();
    }
    public static void geraLex(){
        String path = "/home/marcos/compiler/LuaCompiler/src/lua/lexer.flex";
        File f = new File(path);
        jflex.Main.generate(f);
    }

    private static void testaLex() {
        try {
            String testFile = "/home/marcos/compiler/LuaCompiler/src/lua/test.lua";
            Lexer lex = new Lexer(new FileReader(testFile));
            System.out.println("-------------------------------------");
            Symbol actual = lex.next_token();
            while (actual.sym > 0){ //EOF
                actual = lex.next_token();
            }
            System.out.println("-------------------------------------");
        } catch (Exception ex) {
            Logger.getLogger(Main.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private static void geraParser(){
        try {
            //java -jar ../include/java-cup-11a.jar -parser Parser -symbols Sym -destdir ./lua/ ./lua/Parser.cup
            String[] cup = {"-parser","Parser","-symbols","Sym","-destdir","/home/marcos/compiler/LuaCompiler/src/lua/", "/home/marcos/compiler/LuaCompiler/src/lua/Parser.cup"};
            java_cup.Main.main(cup);
        } catch (Exception ex) {
            Logger.getLogger(Main.class.getName()).log(Level.SEVERE, null, ex);
        }
       
    }

    private static void testaParser() {
        try {
            String testFile = "/home/marcos/compiler/LuaCompiler/src/lua/test.lua";
            Parser p = new Parser(new Lexer(new FileReader(testFile)));
            Object result = p.parse().value;
            System.out.println("Compilacao concluída com sucesso!");
        } catch (Exception ex) {
            Logger.getLogger(Main.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
