import std.stdio;
import sal_shared_api;
import std.string;
import sal_auxlib;
import std.conv;
import std.process;
import std.signals;
import std.path;
import core.stdc.signal;
import std.file;

extern (C) char* readline(const char* prompt);
extern (C) void add_history(const char* prompt);

extern (C) int system(const char*);

import core.sys.posix.signal;

// int repl = 0;

// extern (C) void recover(int _) {
//   writeln("\n^C");
// }

int startRepl(SalmonSub s) {
  auto ps1 = s.value_at(0).getValue();

  auto paths = s.value_at(1).getValue();

  auto proc = spawnProcess("sh", ["PATH": paths, "PS1": ps1]);

  wait(proc);

  s.returnValue(new SalmonValue());
  return 0;
}

int getFilesInDir(SalmonSub s) {
  string dir = s.value_at(0).getValue();

  SalmonValue endResult = new SalmonValue();

  endResult.flagAsList();

  foreach (string dirent ; dirEntries(dir, SpanMode.shallow)) {
    dirent = baseName(dirent);
    SalmonValue entry = new SalmonValue();
    entry.setType(SalType.str);
    entry.setValue(dirent);

    listAppendV(entry, endResult);
  }

  s.returnValue(endResult);

  return 0;
}

extern (C) int sal_lib_init(SalmonEnvironment env) {
  env.env_funcs["begin"] = &startRepl;
  env.env_funcs["getfiles"] = &getFilesInDir;

  return 0;
}
