#!/usr/bin/env python3
# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.
'''`swiftc` wrapper that injects Spoor instrumentation and links in Spoor's
runtime library.'''

from shared import SPOOR_INSTRUMENTATION_XCODE_OUTPUT_FILE_MAP_KEY, BuildTools
import argparse
import json
import os
import pathlib
import subprocess
import sys
import tempfile


def main(argv, build_tools):
  args = argv[1:]

  # Version check
  if args[0] == "-v" and len(args) == 1:
    subprocess.run([build_tools.swiftc, "-v"], env=os.environ, check=True)
    return

  parsable_args = []
  for arg in args:
    if arg.startswith("@"):
      # Handle response files
      response_file = arg[1:]
      with open(response_file, "r") as f:
        for line in f.read().splitlines():
          # Strip leading and trailing quotes from each line
          parsable_args.append(line[1:-1])
    else:
      parsable_args.append(arg)

  parser = argparse.ArgumentParser()
  parser.add_argument('-output-file-map', dest='output_file_map_path')
  known_args, _ = parser.parse_known_args(parsable_args)

  if known_args.output_file_map_path is None:
    raise NotImplementedError(
        "Spoor's swiftc wrapper requires an output file map.", args)

  with tempfile.NamedTemporaryFile() as tmp:
    with open(known_args.output_file_map_path, 'r', encoding='utf-8') as file:
      output_file_map = json.load(file)
      for source, outputs in output_file_map.items():
        if 'llvm-bc' in outputs:
          llvm_bc_path = pathlib.Path(outputs['llvm-bc'])
          output_file_map[source]['spoor-symbols'] = str(
              llvm_bc_path.with_suffix('.spoor_symbols'))
          output_file_map[source]['instrumented-llvm-bc'] = str(
              llvm_bc_path.with_suffix('.instrumented.bc'))
        elif 'object' in outputs:
          llvm_bc_path = pathlib.Path(outputs['object']).with_suffix('.bc')
          outputs['llvm-bc'] = str(llvm_bc_path)
          output_file_map[source]['spoor-symbols'] = str(
              llvm_bc_path.with_suffix('.spoor_symbols'))
          output_file_map[source]['instrumented-llvm-bc'] = str(
              llvm_bc_path.with_suffix('.instrumented.bc'))

        with open(tmp.name, 'w', encoding='utf-8') as tmp_file:
          json.dump(output_file_map, tmp_file)

    env = os.environ.copy()
    env[SPOOR_INSTRUMENTATION_XCODE_OUTPUT_FILE_MAP_KEY] = \
        tmp.name

    swiftc_args = [
        build_tools.swiftc,
        '-driver-use-frontend-path',
        build_tools.spoor_swift,
    ] + args + [
        '-emit-bc',
        '-output-file-map',
        tmp.name,
    ]

    subprocess.run(swiftc_args, env=env, check=True)


if __name__ == '__main__':
  main(sys.argv, BuildTools.get())
