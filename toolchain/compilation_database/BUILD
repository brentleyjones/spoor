# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

load(
    "@rules_cc//cc:defs.bzl",
    "cc_binary",
    "cc_library",
    "cc_proto_library",
    "cc_test",
)
load("@rules_proto//proto:defs.bzl", "proto_library")
load(
    "//toolchain:config.bzl",
    "SPOOR_DEFAULT_COPTS",
    "SPOOR_DEFAULT_LINKOPTS",
    "SPOOR_DEFAULT_TEST_COPTS",
    "SPOOR_DEFAULT_TEST_LINKOPTS",
)

cc_proto_library(
    name = "extra_actions_base_cc_proto",
    tags = ["manual"],
    deps = [
        "@com_bazelbuild_bazel//src/main/protobuf:extra_actions_base_proto",
    ],
)

proto_library(
    name = "compile_commands_proto",
    srcs = ["compile_commands.proto"],
    tags = ["manual"],
    visibility = ["//visibility:private"],
)

cc_proto_library(
    name = "compile_commands_cc_proto",
    tags = ["manual"],
    visibility = ["//visibility:private"],
    deps = [":compile_commands_proto"],
)

cc_library(
    name = "compilation_database_util",
    srcs = ["compilation_database_util.cc"],
    hdrs = ["compilation_database_util.h"],
    copts = SPOOR_DEFAULT_COPTS,
    linkopts = SPOOR_DEFAULT_LINKOPTS,
    tags = ["manual"],
    visibility = ["//visibility:private"],
    deps = [
        ":compile_commands_cc_proto",
        ":extra_actions_base_cc_proto",
        "//util:result",
        "@abseil-cpp//absl/strings",
        "@com_microsoft_gsl//:gsl",
        "@protobuf",
    ],
)

cc_test(
    name = "compilation_database_util_test",
    size = "small",
    srcs = ["compilation_database_util_test.cc"],
    copts = SPOOR_DEFAULT_TEST_COPTS,
    linkopts = SPOOR_DEFAULT_TEST_LINKOPTS,
    visibility = ["//visibility:private"],
    deps = [
        ":compilation_database_util",
        "@abseil-cpp//absl/strings",
        "@googletest//:gtest_main",
    ],
)

cc_binary(
    name = "extract_compile_command",
    srcs = [
        "extract_compile_command.cc",
    ],
    copts = SPOOR_DEFAULT_COPTS,
    linkopts = SPOOR_DEFAULT_LINKOPTS,
    visibility = ["//visibility:public"],
    deps = [
        ":compilation_database_util",
        "@abseil-cpp//absl/flags:flag",
        "@abseil-cpp//absl/flags:parse",
        "@abseil-cpp//absl/flags:usage",
        "@abseil-cpp//absl/strings",
    ],
)

cc_binary(
    name = "concatenate_compile_commands",
    srcs = ["concatenate_compile_commands.cc"],
    copts = SPOOR_DEFAULT_COPTS,
    linkopts = SPOOR_DEFAULT_LINKOPTS,
    visibility = ["//visibility:public"],
    deps = [
        ":compilation_database_util",
        "@abseil-cpp//absl/flags:flag",
        "@abseil-cpp//absl/flags:parse",
        "@abseil-cpp//absl/flags:usage",
    ],
)

action_listener(
    name = "extract_compile_command_listener",
    extra_actions = [":extract_compile_command_action"],
    mnemonics = ["CppCompile"],
    visibility = ["//visibility:public"],
)

extra_action(
    name = "extract_compile_command_action",
    cmd = "$(location :extract_compile_command) \
        --extra_action_file=$(EXTRA_ACTION_FILE) \
        --output_file=$(output $(ACTION_ID).compile_command.pb)",
    out_templates = ["$(ACTION_ID).compile_command.pb"],
    tools = [":extract_compile_command"],
    visibility = ["//visibility:public"],
)
