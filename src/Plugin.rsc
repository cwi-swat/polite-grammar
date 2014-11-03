module Plugin

import lang::polite::Polite;
import util::IDE;
import ParseTree;
import IO;

void main() {
  registerLanguage("Polite", "pol", start[Program](str src, loc l) {
     return parse(#start[Program], src, l);
  });
}