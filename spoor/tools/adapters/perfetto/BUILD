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

cc_proto_library(
    name = "perfetto_trace_cc_proto",
    visibility = ["//visibility:public"],
    deps = ["@perfetto//:protos_perfetto_trace_non_minimal_protos"],
)

cc_library(
    name = "perfetto_adapter_private",
    srcs = ["perfetto_adapter_private.cc"],
    hdrs = ["perfetto_adapter_private.h"],
    copts = SPOOR_DEFAULT_COPTS,
    linkopts = SPOOR_DEFAULT_LINKOPTS,
    tags = ["manual"],
    visibility = ["//visibility:private"],
    deps = [
        "//spoor/runtime/trace",
        "//util:numeric",
        "@com_google_cityhash//:city_hash",
    ],
)

cc_library(
    name = "perfetto_adapter",
    srcs = ["perfetto_adapter.cc"],
    hdrs = ["perfetto_adapter.h"],
    copts = SPOOR_DEFAULT_COPTS,
    linkopts = SPOOR_DEFAULT_LINKOPTS,
    tags = ["manual"],
    visibility = ["//visibility:public"],
    deps = [
        ":perfetto_adapter_private",
        ":perfetto_trace_cc_proto",
        "//spoor/instrumentation/symbols:symbols_cc_proto",
        "//spoor/runtime/trace",
        "//util:numeric",
        "@abseil-cpp//absl/strings",
        "@abseil-cpp//absl/strings:str_format",
        "@com_microsoft_gsl//:gsl",
        "@protobuf",
    ],
)

cc_test(
    name = "perfetto_adapter_test",
    size = "small",
    srcs = ["perfetto_adapter_test.cc"],
    copts = SPOOR_DEFAULT_TEST_COPTS,
    linkopts = SPOOR_DEFAULT_TEST_LINKOPTS,
    visibility = ["//visibility:private"],
    deps = [
        ":perfetto_adapter",
        ":perfetto_adapter_private",
        ":perfetto_trace_cc_proto",
        "//spoor/instrumentation/symbols:symbols_cc_proto",
        "//spoor/runtime/trace",
        "@abseil-cpp//absl/strings",
        "@abseil-cpp//absl/strings:str_format",
        "@com_google_cityhash//:city_hash",
        "@googletest//:gtest_main",
        "@protobuf",
    ],
)
