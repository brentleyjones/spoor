# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

load("@rules_cc//cc:defs.bzl", "cc_library", "cc_test")
load(
    "//toolchain:config.bzl",
    "SPOOR_DEFAULT_COPTS",
    "SPOOR_DEFAULT_LINKOPTS",
    "SPOOR_DEFAULT_TEST_COPTS",
    "SPOOR_DEFAULT_TEST_LINKOPTS",
)

cc_library(
    name = "config",
    srcs = ["config.cc"],
    hdrs = ["config.h"],
    copts = SPOOR_DEFAULT_COPTS,
    linkopts = SPOOR_DEFAULT_LINKOPTS,
    tags = ["manual"],
    visibility = ["//spoor/tools:__subpackages__"],
    deps = [
        "//util/flat_map",
    ],
)

cc_test(
    name = "config_test",
    size = "small",
    srcs = ["config_test.cc"],
    copts = SPOOR_DEFAULT_TEST_COPTS,
    linkopts = SPOOR_DEFAULT_TEST_LINKOPTS,
    visibility = ["//visibility:private"],
    deps = [
        ":config",
        "@googletest//:gtest_main",
    ],
)

cc_library(
    name = "command_line_config",
    srcs = ["command_line_config.cc"],
    hdrs = ["command_line_config.h"],
    copts = SPOOR_DEFAULT_COPTS,
    linkopts = SPOOR_DEFAULT_LINKOPTS,
    tags = ["manual"],
    visibility = ["//spoor/tools:__pkg__"],
    deps = [
        ":config",
        "//util/env",
        "//util/file_system",
        "@abseil-cpp//absl/flags:flag",
        "@abseil-cpp//absl/flags:parse",
        "@abseil-cpp//absl/strings",
    ],
)

cc_test(
    name = "command_line_config_test",
    size = "small",
    srcs = ["command_line_config_test.cc"],
    copts = SPOOR_DEFAULT_TEST_COPTS,
    linkopts = SPOOR_DEFAULT_TEST_LINKOPTS,
    visibility = ["//visibility:private"],
    deps = [
        ":command_line_config",
        "//util/env",
        "//util/file_system",
        "@com_microsoft_gsl//:gsl",
        "@googletest//:gtest_main",
    ],
)
