#pragma once

#include <iostream>
#include <string>
#include <vector>

#include "./ezOptionParser.hpp"

#include "dreal/solver/config.h"

namespace dreal {

/// dReal's main program. It parses options from command line and
/// process a given file (either .smt2 or .dr file).
class MainProgram {
 public:
  /// Constructs a main program using given command-line arguments.
  MainProgram(int argc, const char* argv[]);
  /// Executes the main program.
  int Run();

 private:
  void PrintUsage();
  void AddOptions();
  bool ValidateOptions();

  // Extracts options from `opt_` and construts `config_`.
  void ExtractOptions();

  bool is_options_all_valid_{false};
  ez::ezOptionParser opt_;
  std::vector<const std::string*> args_;  // List of valid option arguments.
  Config config_;
};
}  // namespace dreal
