package sample;

import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author marcos
 */
public class Main {
    
    public static void main(String[] args){
//        geraLex();
        testaLex();
//        geraParser();
//        testaParser();
    }
    public static void geraLex(){
        String path = "/home/marcos/compiler/LuaCompiler/src/scanner/lexer.flex";
        File f = new File(path);
        jflex.Main.generate(f);
    }

    private static void testaLex() {
        try {
            String testFile = "/home/marcos/compiler/LuaCompiler/src/sample/test.my";
            Lexer lex = new Lexer(new FileReader(testFile));
        } catch (IOException ex) {
            Logger.getLogger(Main.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private static void geraParser() {
        try {
            String[] cup = {"/home/marcos/compiler/LuaCompiler/src/sample/Parser.cup"};
            java_cup.Main.main(cup);
        } catch (Exception ex) {
            Logger.getLogger(Main.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private static void testaParser() {
        try {
            String testFile = "/home/marcos/compiler/LuaCompiler/src/scanner/test.my";
            Parser p = new Parser(new Lexer(new FileReader(testFile)));
            Object result = p.parse().value;
            System.out.println("Compilacao concluída com sucesso!");
        } catch (Exception ex) {
            Logger.getLogger(Main.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
