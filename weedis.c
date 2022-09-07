#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <inttypes.h>

#include "common.h"
#include "vm.h"
#include "test.h"
#include "weewasm.h"
#include "illegal.h"

// Does the work of disassembling the binary. You must implement this.
void disassemble(const byte* start, const byte* end);

// Main function.
// Parses arguments and either loads files or runs the tests.
//  -trace: enable tracing to stderr
//  -test: run internal tests
int main(int argc, char *argv[]) {
  for (int i = 1; i < argc; i++) {
    char *arg = argv[i];
    if (strcmp(arg, "-test") == 0) return run_tests();
    if (strcmp(arg, "-trace") == 0) {
      g_trace = 1;
      continue;
    }
    
    byte* start = NULL;
    byte* end = NULL;
    ssize_t r = load_file(arg, &start, &end);
    if (r >= 0) {
      TRACE("loaded %s: %ld bytes\n", arg, r);
      disassemble(start, end);
      unload_file(&start, &end);
    } else {
      ERR("failed to load: %s\n", arg);
    }
  }
  return 0;
}

// Returns the string name of a section code.
const char* section_name(byte code) {
  switch (code) {
  case WASM_SECT_TYPE: return "type";
  case WASM_SECT_IMPORT: return "import";
  case WASM_SECT_FUNCTION: return "function";
  case WASM_SECT_TABLE: return "table";
  case WASM_SECT_MEMORY: return "memory";
  case WASM_SECT_GLOBAL: return "global";
  case WASM_SECT_EXPORT: return "export";
  case WASM_SECT_START: return "start";
  case WASM_SECT_ELEMENT: return "element";
  case WASM_SECT_CODE: return "code";
  case WASM_SECT_DATA: return "data";
  case 0: return "custom";
  default:
    return "unknown";
  }
}

//========= BEGIN SOLUTION ==========

void disassemble(const byte* start, const byte* end) {
  // TODO
}
