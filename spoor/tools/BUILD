# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

load("@rules_cc//cc:defs.bzl", "cc_binary", "cc_library", "cc_test")
load(
    "//toolchain:config.bzl",
    "SPOOR_DEFAULT_COPTS",
    "SPOOR_DEFAULT_LINKOPTS",
    "SPOOR_DEFAULT_TEST_COPTS",
    "SPOOR_DEFAULT_TEST_LINKOPTS",
)

cc_library(
    name = "tools_info",
    hdrs = ["tools.h"],
    copts = SPOOR_DEFAULT_COPTS,
    linkopts = SPOOR_DEFAULT_LINKOPTS,
    tags = ["manual"],
    visibility = ["//visibility:private"],
)

cc_library(
    name = "spoor_lib",
    srcs = ["spoor.cc"],
    copts = SPOOR_DEFAULT_COPTS,
    linkopts = SPOOR_DEFAULT_LINKOPTS,
    tags = ["manual"],
    visibility = [
        "//spoor/tools:__pkg__",
        "//spoor/tools/wrappers/apple:__pkg__",
    ],
    deps = [
        ":tools_info",
        "//spoor/instrumentation:instrumentation_info",
        "//spoor/instrumentation/symbols:symbols_cc_proto",
        "//spoor/instrumentation/symbols:symbols_reader",
        "//spoor/instrumentation/symbols:symbols_utility",
        "//spoor/instrumentation/symbols:symbols_writer",
        "//spoor/runtime/trace",
        "//spoor/tools/config",
        "//spoor/tools/config:command_line_config",
        "//spoor/tools/serialization:serialize",
        "//util:numeric",
        "//util/compression",
        "//util/env",
        "@abseil-cpp//absl/flags:flag",
        "@abseil-cpp//absl/flags:parse",
        "@abseil-cpp//absl/flags:usage",
        "@abseil-cpp//absl/strings",
        "@abseil-cpp//absl/strings:str_format",
        "@com_microsoft_gsl//:gsl",
    ],
)

cc_binary(
    name = "spoor",
    copts = SPOOR_DEFAULT_COPTS,
    linkopts = SPOOR_DEFAULT_LINKOPTS,
    visibility = ["//visibility:public"],
    deps = [":spoor_lib"],
)
