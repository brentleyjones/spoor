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
    name = "source",
    srcs = [
        "env_source.cc",
        "file_source.cc",
    ],
    hdrs = [
        "env_source.h",
        "file_source.h",
        "source.h",
    ],
    copts = SPOOR_DEFAULT_COPTS,
    linkopts = SPOOR_DEFAULT_LINKOPTS,
    tags = ["manual"],
    visibility = ["//spoor/runtime:__subpackages__"],
    deps = [
        "//spoor/runtime/buffer",
        "//spoor/runtime/trace",
        "//util:numeric",
        "//util:result",
        "//util/compression",
        "//util/env",
        "//util/file_system",
        "@abseil-cpp//absl/strings",
        "@abseil-cpp//absl/strings:str_format",
        "@com_marzer_tomlplusplus//:tomlplusplus",
        "@com_microsoft_gsl//:gsl",
    ],
)

cc_library(
    name = "config",
    srcs = ["config.cc"],
    hdrs = ["config.h"],
    copts = SPOOR_DEFAULT_COPTS,
    linkopts = SPOOR_DEFAULT_LINKOPTS,
    tags = ["manual"],
    visibility = ["//spoor/runtime:__subpackages__"],
    deps = [
        ":source",
        "//spoor/common/config:util",
        "//spoor/runtime/buffer",
        "//spoor/runtime/trace",
        "//util:numeric",
        "//util/compression",
        "//util/env",
        "//util/file_system",
        "@abseil-cpp//absl/strings",
    ],
)

cc_library(
    name = "source_mock",
    testonly = True,
    hdrs = ["source_mock.h"],
    copts = SPOOR_DEFAULT_COPTS,
    linkopts = SPOOR_DEFAULT_LINKOPTS,
    tags = ["manual"],
    visibility = ["//spoor/runtime:__subpackages__"],
    deps = [
        ":source",
        "//spoor/runtime/trace",
        "//util:numeric",
        "//util/compression",
        "@googletest//:gtest",
    ],
)

cc_test(
    name = "source_test",
    size = "small",
    srcs = [
        "env_source_test.cc",
        "file_source_test.cc",
    ],
    copts = SPOOR_DEFAULT_TEST_COPTS,
    linkopts = SPOOR_DEFAULT_TEST_LINKOPTS,
    visibility = ["//visibility:private"],
    deps = [
        ":source",
        "//spoor/runtime/buffer",
        "//spoor/runtime/trace",
        "//util/file_system:file_system_mock",
        "//util/flat_map",
        "@abseil-cpp//absl/strings:str_format",
        "@googletest//:gtest_main",
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
        ":source",
        ":source_mock",
        "//spoor/runtime/trace",
        "//util/compression",
        "@googletest//:gtest_main",
    ],
)
