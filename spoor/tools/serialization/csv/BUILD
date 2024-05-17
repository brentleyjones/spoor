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
    name = "csv",
    srcs = ["csv.cc"],
    hdrs = ["csv.h"],
    copts = SPOOR_DEFAULT_COPTS,
    linkopts = SPOOR_DEFAULT_LINKOPTS,
    tags = ["manual"],
    visibility = ["//visibility:public"],
    deps = [
        "//spoor/instrumentation/symbols:symbols_cc_proto",
        "//spoor/runtime/trace",
        "//util:result",
        "@abseil-cpp//absl/strings",
        "@abseil-cpp//absl/strings:str_format",
        "@com_microsoft_gsl//:gsl",
        "@protobuf",
    ],
)

cc_test(
    name = "csv_test",
    size = "small",
    srcs = ["csv_test.cc"],
    copts = SPOOR_DEFAULT_TEST_COPTS,
    linkopts = SPOOR_DEFAULT_TEST_LINKOPTS,
    visibility = ["//visibility:private"],
    deps = [
        ":csv",
        "//spoor/instrumentation/symbols:symbols_cc_proto",
        "@googletest//:gtest_main",
        "@protobuf",
    ],
)
